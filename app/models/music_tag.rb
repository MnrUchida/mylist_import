# == Schema Information
#
# Table name: music_tags
#
#  id                       :integer          not null, primary key
#  music_tag_articles_count :integer
#  name                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class MusicTag < ApplicationRecord
  include TagConcern

  has_many :music_tag_articles, dependent: :restrict_with_exception, counter_cache: true
  has_many :articles, through: :music_tag_articles
  has_many :music_tag_musics, dependent: :restrict_with_exception

  def self.update_count
    all.each do |tag|
      tag.update(music_tag_articles_count: tag.music_tag_articles.count)
    end
  end
end
