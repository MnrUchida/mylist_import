class CreateMusicTagArticle < ActiveRecord::Migration[7.0]
  def change
    create_table :music_tag_articles do |t|
      t.belongs_to :music_tag
      t.belongs_to :article

      t.timestamps
    end
  end
end
