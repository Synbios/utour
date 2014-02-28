class UserGroup < ActiveRecord::Base
  validates :name, :presence => { :message => "用户组名为必填" }, :uniqueness => { :message => "此用户组已存在" }
  validate :check_parent_id

  #has_many :user_group_permission_hashes
  has_many :accounts
  has_many :invitation_codes
  belongs_to :user_group, :foreign_key => "parent_id"

  has_many :m, :class_name => 'UserGroupMap', :foreign_key => 'up'
  #has_many :down_user_groups, :through => :down_user_group_maps, :foreign_key => 'down'
  has_many :up_relations, :class_name => 'UserGroupMap', :foreign_key => 'down'


  #has_many :agent_sales, :class_name => 'SaleAgent', :foreign_key => 'agent_id'
  #has_many :sales, :through => :agent_sales, :foreign_key => 'sale_id'
  # return a hash of user group hierarchy
  # note: this method requires polynomial database lookups avoid using it when possible
  def self.get_tree(user_group_id)
    root_name = "root"
    root_name = UserGroup.find_by_id(user_group_id).name if UserGroup.find_by_id(user_group_id)
    tree = {
      :name => root_name,
      :id => user_group_id,
      :members => []
    }
    stack = [tree]

    until stack.empty?
      expand = stack.pop
      recruits = UserGroup.where("parent_id = ?", expand[:id])
      recruits.each do |recruit|
        hash = {
          :name => recruit.name,
          :id => recruit.id,
          :members => []
        }
        expand[:members].push hash
        stack.push hash
      end
    end
    tree
  end

  def self.get_trees
    roots = UserGroup.where("parent_id = 0")
    trees = []
    roots.each do |root|
      trees.push self.get_tree2 root
    end
    trees
  end

  def self.get_tree2(root=nil)
    #puts "INSIDE>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    return "" if root.nil?
    #puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

    tree = {
      :name => root.name,
      :object => root,
      :id => root.id,
      :parent_id => root.parent_id,
      :parent_name => root.parent_id == 0 ? "行政树顶层" : root.user_group.name,
      :members => []
    }
    #puts ">>>>>>>>>> #{tree}"
    stack = [tree]

    until stack.empty?
      expand = stack.pop
      recruits = UserGroup.where "parent_id = ?", expand[:id]
      recruits.each do |recruit|
        hash = {
          :name => recruit.name,
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
    puts tree
    tree
  end

  
  

  def self.convert_name_string_to_id_string(name_string)
    return "" if name_string.nil?
    ids = []
    name_string.split.each do |name|
      id = UserGroup.find_by_name(name)
      ids.push id.id if id.present?
    end
    return ids.join(" ")
  end

  def self.convert_id_string_to_name_string(id_string)
    return "" if id_string.nil?
    names = []
    id_string.split.each do |id|
      name = UserGroup.find_by_id(id)
      names.push name.name if name.present?
    end
    return names.join(" ")
  end

private
  def check_parent_id
    if parent_id.nil?
      errors.add(:parent_id, "缺少上级用户组")
    elsif parent_id != 0 && UserGroup.find_by_id(parent_id).nil?
      errors.add(:parent_id, "上级用户组(parent_id = #{parent_id})不存在")
    end
  end
end
