# == Schema Information
#
# Table name: musics
#
#  id         :integer          not null, primary key
#  code       :string
#  note       :text
#  title      :string           not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Music < ApplicationRecord
  include UrlConcern

  has_many :articles
  has_many :music_tag_musics, dependent: :restrict_with_exception
  has_many :music_tags, through: :music_tag_musics

  scope :order_by_article_count, -> { joins(:articles).group(Music.column_names).order(Arel.sql("COUNT(articles.id) DESC")) }

  def tag_ids=(value)
    return if value.blank?

    value.split(',').each do |tag_id|
      self.music_tag_musics.build(music_tag_id: tag_id) if self.music_tag_musics.where(music_tag_id: tag_id).blank?
    end
  end

  def tag_ids
    self.music_tag_musics.map(&:music_tag_id)
  end
end
