class AddImagePathToUserSquares < ActiveRecord::Migration[7.1]
  def change
    add_column :user_squares, :image_path, :string
  end
end
