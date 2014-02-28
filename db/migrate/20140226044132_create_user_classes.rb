class CreateUserClasses < ActiveRecord::Migration
  def change
    create_table :user_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
