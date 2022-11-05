class RemoveNotNullConstarintFromMusic < ActiveRecord::Migration[7.0]
  def change
    change_column :musics, :url, :string, null: true
    change_column :musics, :code, :string, null: true
  end
end
