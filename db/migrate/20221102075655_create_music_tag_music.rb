class CreateMusicTagMusic < ActiveRecord::Migration[7.0]
  def change
    create_table :music_tag_musics do |t|
      t.belongs_to :music_tag
      t.belongs_to :music

      t.timestamps
    end
  end
end
