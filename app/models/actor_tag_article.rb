# == Schema Information
#
# Table name: actor_tag_articles
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  actor_tag_id :integer
#  article_id   :integer
#
# Indexes
#
#  index_actor_tag_articles_on_actor_tag_id  (actor_tag_id)
#  index_actor_tag_articles_on_article_id    (article_id)
#
class ActorTagArticle < ApplicationRecord
  belongs_to :article
  belongs_to :actor_tag

  scope :not_by_names, ->(value) { where(actor_tag_id: ActorTag.not_by_names(value)) }
end
