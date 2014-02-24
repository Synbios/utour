class UserGroup < ActiveRecord::Base
  validates :name, :presence => { :message => "用户组名为必填" }, :uniqueness => { :message => "此用户组已存在" }
  validate :check_parent_id

  has_many :user_group_permission_hashes
  has_many :accounts
  has_many :invitation_codes

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

  def self.hash_tree_to_list(hash, out="")
    members = hash[:members]
    unless members.empty?
      out += "<ul>"
      members.each do |member|
        out += "<li><a ref='' class=\"btn btn-primary\">#{member[:name]}</a>"
        out = self.hash_tree_to_list(member, out)
        out += "</li>"
      end
      out += "</ul>"
    end
    out
  end

  def self.sub_tree(start_node_id)
    tree = UserGroup.get_tree(start_node_id)
    return tree if start_node_id == :root
    node = nil
    stack = [tree]
    until !node.nil? || stack.empty?
      expand = stack.pop
      if expand[:id] == start_node_id
        node = expand
      else
        expand[:members].each do |member|
          stack.push member
        end
      end
    end
    node
  end

  def self.to_admin_list(start_user_group_id = 0)
    tree = self.get_tree(start_user_group_id)
    out = ""
    unless tree.nil?
      out += "<ul>"
      out += self.render_tree_list(tree)
      out += "</ul>"
    end
    out
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

  def self.render_tree_list(hash, out="")
    unless hash.nil?
      out += "<li>"
      if hash[:members].empty?
        out += "<span> #{hash[:name]}</span>"
      else
        out += "<span><i class=\"fa fa-lg fa-minus-circle\"></i> #{hash[:name]}</span>"
      end
      
      #<a href=\"admin/user_groups/new?parent_id=#{hash[:id]}\">新建</a>
      if hash[:id] == 0
        out += " <button onclick=\"new_user_group(#{hash[:id]}, '#{hash[:name]}')\", class=\"btn btn-primary btn-sm\">添加</button>"
      else
        out += " <button onclick=\"new_user_group(#{hash[:id]}, '#{hash[:name]}')\", class=\"btn btn-primary btn-sm\">添加</button> <a href='/admin/user_groups/#{hash[:id]}' rel=\"nofollow\" data-method=\"delete\" class=\"btn btn-danger btn-sm\">删除</a>"
      end
      unless hash[:members].empty?
        out += "<ul>"
        hash[:members].each do |member|
          out = self.render_tree_list(member, out)
        end
        out += "</ul>"
      end
      out += "</li>"
    end
    out
  end
end
