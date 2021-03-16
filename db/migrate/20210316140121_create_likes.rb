class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_keys: true
      t.references :play, null: false, foreign_keys: true
      t.timestamps
    end
  end
end
