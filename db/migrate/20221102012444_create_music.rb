class CreateMusic < ActiveRecord::Migration[7.0]
  def change
    create_table :musics do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :code, null: false
      t.text :note

      t.timestamps
    end
  end
end
