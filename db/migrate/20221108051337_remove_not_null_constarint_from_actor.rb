class RemoveNotNullConstarintFromActor < ActiveRecord::Migration[7.0]
  def change
    change_column :actors, :url, :string, null: true
    change_column :actors, :code, :string, null: true
  end
end
