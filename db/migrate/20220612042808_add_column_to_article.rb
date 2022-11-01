class AddColumnToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :code, :string
    add_index :articles, :code, unique: true
  end
end
