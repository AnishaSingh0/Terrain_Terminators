class AddWordsToSquares < ActiveRecord::Migration[7.1]
  def change
    add_column :squares, :words, :string
  end
end
