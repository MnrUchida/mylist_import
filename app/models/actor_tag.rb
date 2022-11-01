# == Schema Information
#
# Table name: actor_tags
#
#  id                       :integer          not null, primary key
#  actor_tag_articles_count :integer
#  name                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class ActorTag < ApplicationRecord
  include TagConcern

  has_many :actor_tag_articles, dependent: :restrict_with_exception, counter_cache: true
  has_many :articles, through: :actor_tag_articles

  def self.update_count
    all.each do |tag|
      tag.update(actor_tag_articles_count: tag.actor_tag_articles.count)
    end
  end
end
