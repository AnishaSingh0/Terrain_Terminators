class AddRemainingWordsToSquare < ActiveRecord::Migration[7.1]
  def change
    add_column :squares, :remaining_words, :string
  end
end
