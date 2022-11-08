class CreateActorTagActor < ActiveRecord::Migration[7.0]
  def change
    create_table :actor_tag_actors do |t|
      t.belongs_to :actor_tag
      t.belongs_to :actor

      t.timestamps
    end
  end
end
