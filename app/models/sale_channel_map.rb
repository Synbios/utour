class SaleChannelMap < ActiveRecord::Base
  belongs_to :up, class_name: "SaleChannel", :foreign_key => :up_id
  belongs_to :down, class_name: "SaleChannel", :foreign_key => :down_id
  # rebuild the hash from SaleChannel table
  def self.reload
    # delete everything in the table
    self.delete_all
    # this is the data hash (tree)
    trees = SaleChannel.get_trees

    trees.each do |tree|
      # this is the array that contains all ancestors of the node
      ancestors = [SaleChannel.new(id: 0)] # dummy variable to get the 0 index

      # now make the recursive call
      self.insert_new_permissions(tree, ancestors)
    end
  end

  def self.desc_sale_channels(sale_channel_id)
    SaleChannelMap.where(up_id: sale_channel_id).map { |record| SaleChannel.find_by_id(record.down) }
  end

  private
   def self.insert_new_permissions(node, ancestors)
    ancestors.each do |ancestor|
      self.new( up_id: ancestor[:id], down_id: node[:id] ).save
      #puts "insert new record: #{node[:id]} -> #{ancestor[:id]}"
    end
    unless node[:members].empty?
      ancestors.push node
      node[:members].each do |member|
        self.insert_new_permissions(member, ancestors)
      end
      ancestors.pop
    end
  end
end
