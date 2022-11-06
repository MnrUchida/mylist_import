class AddMusicIdToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :music_id, :bigint
  end
end
