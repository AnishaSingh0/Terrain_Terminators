class AddImageUrlToSquares < ActiveRecord::Migration[7.1]
  def change
    add_column :squares, :image_url, :string
  end
end
