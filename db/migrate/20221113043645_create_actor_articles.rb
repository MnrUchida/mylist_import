class CreateActorArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :actor_articles do |t|
      t.belongs_to :actor
      t.belongs_to :article

      t.timestamps
    end
  end
end
