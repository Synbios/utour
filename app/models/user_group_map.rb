class UserGroupMap < ActiveRecord::Base
  belongs_to :up, class_name: "UserGroup", :foreign_key => :up_id
  belongs_to :down, class_name: "UserGroup", :foreign_key => :down_id

  

  # rebuild the hash from UserGroup table
  def self.reload
    # delete everything in the table
    self.delete_all
    # this is the data hash (tree)
    trees = UserGroup.get_trees

    trees.each do |tree|
      # this is the array that contains all ancestors of the node
      ancestors = [UserGroup.new(id: 0)] # dummy variable to get the 0 index

      # now make the recursive call
      self.insert_new_permissions(tree, ancestors)
    end

    
  end

  def self.desc_sale_channels(user_group_id)
    UserGroupMap.where(up_id: user_group_id).map { |record| UserGroup.find_by_id(record.down) }.compact
  end

  private
  def self.insert_new_permissions(node, ancestors)
    ancestors.each do |ancestor|
      puts "insert new record: #{node[:id]} -> #{ancestor[:id]}"
      usergroupmap = UserGroupMap.new
      usergroupmap.up_id = ancestor[:id]
      usergroupmap.down_id = node[:id]
      usergroupmap.save
      
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
