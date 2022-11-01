class CreateActorTagArticle < ActiveRecord::Migration[7.0]
  def change
    create_table :actor_tag_articles do |t|
      t.belongs_to :actor_tag
      t.belongs_to :article

      t.timestamps
    end
  end
end
