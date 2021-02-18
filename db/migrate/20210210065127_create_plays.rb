class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.references :user,            null: false, foreign_keys: true
      t.text       :title,           null: false
      t.datetime   :published_at,    null: false
      t.string     :place,           null: false
      t.integer    :ground_style_id, null: false
      t.string     :detail
      t.float      :latitude,        null: false
      t.float      :longitude,       null: false
      t.timestamps
    end
  end
end
