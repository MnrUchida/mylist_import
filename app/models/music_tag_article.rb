# == Schema Information
#
# Table name: music_tag_articles
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  article_id   :integer
#  music_tag_id :integer
#
# Indexes
#
#  index_music_tag_articles_on_article_id    (article_id)
#  index_music_tag_articles_on_music_tag_id  (music_tag_id)
#
class MusicTagArticle < ApplicationRecord
  belongs_to :article
  belongs_to :music_tag

  scope :not_by_names, ->(value) { where(music_tag_id: MusicTag.not_by_names(value)) }
end
