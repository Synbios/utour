class ChangeAccountUserGroupType < ActiveRecord::Migration
  def change
  	change_column :accounts, :user_group, :integer
  end
end
