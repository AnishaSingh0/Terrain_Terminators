class CreateUserSquares < ActiveRecord::Migration[7.1]
  def change
    create_table :user_squares do |t|
      t.references :user, null: false, foreign_key: true
      t.references :square, null: false, foreign_key: true
      t.string :remaining_words
      t.string :image_path
      t.boolean :is_destroyed, default: false

      t.timestamps
    end
  end
end
