class CreateTagArticle < ActiveRecord::Migration[7.0]
  def change
    create_table :common_tag_articles do |t|
      t.belongs_to :common_tag
      t.belongs_to :article

      t.timestamps
    end
  end
end
