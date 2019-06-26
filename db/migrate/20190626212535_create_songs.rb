class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :length_seconds
      t.integer :track_number
      t.belongs_to :album, foreign_key: true

      t.timestamps
    end
  end
end
