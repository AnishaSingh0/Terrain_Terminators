class CreateSquares < ActiveRecord::Migration[7.1]
  def change
    create_table :squares do |t|
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
