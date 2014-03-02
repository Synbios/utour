class AddImgTypeToImage < ActiveRecord::Migration
  def change
    add_column :images, :image_type, :string
  end
end
