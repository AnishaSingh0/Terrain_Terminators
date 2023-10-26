class SetDefaultIsDestroyedFalse < ActiveRecord::Migration[7.1]
  def change
    change_column :user_squares, :is_destroyed, :boolean, default: false

  end
end
