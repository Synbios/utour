class UserGroup < ActiveRecord::Base
  validates :name, :presence => { :message => "用户组名为必填" }, :uniqueness => { :message => "此用户组已存在" }
  validate :check_parent_id

  # return a hash of user group hierarchy
  # note: this method requires polynomial database lookups avoid using it when possible
  def self.get_tree
    tree = {
      :name => "root",
      :id => 0,
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

  private
  def check_parent_id
    if parent_id.nil?
      errors.add(:parent_id, "缺少上级用户组")
    elsif parent_id != 0 && UserGroup.find_by_id(parent_id).nil?
      errors.add(:parent_id, "上级用户组(parent_id = #{parent_id})不存在")
    end
  end
end
