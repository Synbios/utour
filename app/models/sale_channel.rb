class SaleChannel < ActiveRecord::Base

  belongs_to :sale_channel, :foreign_key => "parent_id"
  def self.get_tree(root=nil)
    return "" if root.nil?

    tree = {
      :name => root.name,
      :abb => root.abb,
      :object => root,
      :id => root.id,
      :parent_id => root.parent_id,
      :parent_name => root.parent_id == 0 ? "渠道树顶层" : root.sale_channel.name,
      :members => []
    }

    stack = [tree]

    until stack.empty?
      expand = stack.pop
      recruits = SaleChannel.where "parent_id = ?", expand[:id]
      recruits.each do |recruit|
        hash = {
          :name => recruit.name,
          :abb => recruit.abb,
          :id => recruit.id,
          :members => [],
          :parent_id => expand[:id],
          :parent_name => expand[:name],
          :object => recruit
        }
        expand[:members].push hash
        stack.push hash
      end
    end
    tree
  end

  def self.get_trees
    roots = SaleChannel.where("parent_id = 0")
    trees = []
    roots.each do |root|
      trees.push self.get_tree root
    end
    trees
  end
end
