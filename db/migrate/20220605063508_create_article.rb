class CreateArticle < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :note

      t.timestamps

      t.index :url, unique: true
    end
  end
end
