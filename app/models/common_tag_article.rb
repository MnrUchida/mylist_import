# == Schema Information
#
# Table name: common_tag_articles
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_id    :integer
#  common_tag_id :integer
#
# Indexes
#
#  index_common_tag_articles_on_article_id     (article_id)
#  index_common_tag_articles_on_common_tag_id  (common_tag_id)
#
class CommonTagArticle < ApplicationRecord
  belongs_to :article
  belongs_to :common_tag

  scope :not_by_names, ->(value) { where(common_tag_id: CommonTag.not_by_names(value)) }
end
