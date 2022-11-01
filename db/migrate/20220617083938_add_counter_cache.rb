class AddCounterCache < ActiveRecord::Migration[7.0]
  def change
    add_column :music_tags, :music_tag_articles_count, :integer
    add_column :actor_tags, :actor_tag_articles_count, :integer
    add_column :common_tags, :common_tag_articles_count, :integer
  end
end
