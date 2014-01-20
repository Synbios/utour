class UserGroupPermissionHash < ActiveRecord::Base
  # rebuild the hash from UserGroup table
  def self.reload
    # delete everything in the table
    self.delete_all
    # this is the data hash (tree)
    data = UserGroup.get_tree

    # this is the array that contains all ancestors of the node
    ancestors = []

    # now make the recursive call
    self.insert_new_permissions(data, ancestors)
  end

  private
   def self.insert_new_permissions(node, ancestors)
    ancestors.each do |ancestor|
      self.new( user_group_id: node[:id], allowed_user_group_id: ancestor[:id] ).save
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
