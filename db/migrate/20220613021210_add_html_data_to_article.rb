class AddHtmlDataToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :html_data, :text
  end
end
