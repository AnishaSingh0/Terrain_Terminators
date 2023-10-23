class CreateUserSquares < ActiveRecord::Migration[7.1]
  def change
    create_table :user_squares do |t|
      t.references :user, foreign_key: true
      t.references :square, foreign_key: true
      t.string :remaining_words
      t.string :image_path
      # Add other columns as needed
      t.timestamps
    end
  end
end
