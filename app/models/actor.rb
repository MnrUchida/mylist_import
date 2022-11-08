# == Schema Information
#
# Table name: actors
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  name       :string           not null
#  note       :text
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Actor < ApplicationRecord
  include UrlConcern

  # has_many :articles
  has_many :actor_tag_actors, dependent: :restrict_with_exception
  has_many :actor_tags, through: :actor_tag_actors

  # scope :order_by_article_count, -> { joins(:articles).group(Music.column_names).order(Arel.sql("COUNT(articles.id) DESC")) }

  def tag_ids=(value)
    return if value.blank?

    value.split(',').each do |tag_id|
      self.actor_tag_actors.build(actor_tag_id: tag_id) if self.actor_tag_actors.where(actor_tag_id: tag_id).blank?
    end
  end

  def tag_ids
    self.actor_tag_actors.map(&:actor_tag_id)
  end
end
