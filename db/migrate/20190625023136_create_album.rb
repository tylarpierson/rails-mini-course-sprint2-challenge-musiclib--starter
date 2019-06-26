class CreateAlbum < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.boolean :available, default: true
      t.belongs_to :artist, foreign_key: true

      t.timestamps
    end
  end
end
