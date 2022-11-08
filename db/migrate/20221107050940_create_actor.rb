class CreateActor < ActiveRecord::Migration[7.0]
  def change
    create_table :actors do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :code, null: false
      t.text :note

      t.timestamps
    end
  end
end
