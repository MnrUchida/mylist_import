# == Schema Information
#
# Table name: actor_tag_actors
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  actor_id     :integer
#  actor_tag_id :integer
#
# Indexes
#
#  index_actor_tag_actors_on_actor_id      (actor_id)
#  index_actor_tag_actors_on_actor_tag_id  (actor_tag_id)
#
class ActorTagActor < ApplicationRecord
  belongs_to :actor
  belongs_to :actor_tag
end
