# == Schema Information
#
# Table name: common_tags
#
#  id                        :integer          not null, primary key
#  common_tag_articles_count :integer
#  name                      :string           not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class CommonTag < ApplicationRecord
  include TagConcern

  has_many :common_tag_articles, dependent: :restrict_with_exception, counter_cache: true
  has_many :articles, through: :common_tag_articles
end
