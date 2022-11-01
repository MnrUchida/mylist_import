class CreateActorTag < ActiveRecord::Migration[7.0]
  def change
    create_table :actor_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
