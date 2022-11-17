# == Schema Information
#
# Table name: actor_articles
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  article_id :integer
#
# Indexes
#
#  index_actor_articles_on_actor_id    (actor_id)
#  index_actor_articles_on_article_id  (article_id)
#
class ActorArticle < ApplicationRecord
  belongs_to :article
  belongs_to :actor
end
