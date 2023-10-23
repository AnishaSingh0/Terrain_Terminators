class AddIsDestroyedToUserSquares < ActiveRecord::Migration[7.1]
  def change
    add_column :user_squares, :is_destroyed, :boolean, default: false
  end
end
