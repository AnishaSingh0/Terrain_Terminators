class AddAvatarFileToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_file, :string
  end
end
