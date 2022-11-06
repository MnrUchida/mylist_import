require 'uri'

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  code       :string
#  html_data  :text
#  note       :text
#  title      :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  music_id   :bigint
#
# Indexes
#
#  index_articles_on_code  (code) UNIQUE
#  index_articles_on_url   (url) UNIQUE
#
class Article < ApplicationRecord
  include UrlConcern

  belongs_to :music
  has_many :actor_tag_articles, dependent: :destroy
  has_many :actor_tags, through: :actor_tag_articles
  has_many :music_tag_articles, dependent: :destroy
  has_many :music_tags, through: :music_tag_articles
  has_many :common_tag_articles, dependent: :destroy
  has_many :common_tags, through: :common_tag_articles

  after_save :update_count

  def common_tag_list
    @common_tag_list ||= common_tags.pluck(:name).join(', ')
  end

  def common_tag_list=(value)
    @common_tag_list = nil

    convert_values = value.gsub(/\s/, '').split(',')
    common_tag_articles.not_by_names(convert_values).destroy_all
    add_common_tag(convert_values)
  end

  def add_common_tag(value)
    value = [value] unless value.is_a?(Array)
    exist_tags = common_tags.by_names(value)
    CommonTag.create_not_exist_data(value)
    CommonTag.by_names(value).where.not(id: exist_tags.ids).each do |tag|
      self.common_tag_articles.build(common_tag: tag)
    end
  end

  def music_list
    @music_list ||= music_tags.pluck(:name).join(', ')
  end

  def music_list=(value)
    @music_list = nil

    convert_values = value.gsub(/\s/, '').split(',')
    music_tag_articles.not_by_names(convert_values).destroy_all
    add_music(convert_values)
  end

  def add_music(value)
    value = [value] unless value.is_a?(Array)
    exist_tags = music_tags.by_names(value)
    MusicTag.create_not_exist_data(value)
    MusicTag.by_names(value).where.not(id: exist_tags.ids).each do |tag|
      self.music_tag_articles.build(music_tag: tag)
    end
  end

  def actor_list
    @actor_list ||= actor_tags.pluck(:name).join(', ')
  end

  def actor_list=(value)
    @actor_list = nil

    convert_values = value.gsub(/\s/, '').split(',')
    actor_tag_articles.not_by_names(convert_values).destroy_all
    add_actor(convert_values)
  end

  def add_actor(value)
    value = [value] unless value.is_a?(Array)
    exist_tags = actor_tags.by_names(value)
    ActorTag.create_not_exist_data(value)
    ActorTag.by_names(value).where.not(id: exist_tags.ids).each do |tag|
      self.actor_tag_articles.build(actor_tag: tag)
    end
  end

  def prev
    @prev ||= Article.where(id: (self.id + 1)..).take
  end

  def next
    @next ||= Article.where(id: ..(self.id - 1)).last
  end

  def parse_html
    parsed = Nokogiri.parse(html_data)
    self.title = parsed.css('.VideoTitle').inner_text
    self.add_actor parsed.css('.VideoOwnerInfo-pageLink').inner_text.match(/(.*) さん/)[1]
    MusicTag.included_tags(initial: %w[踊ってみた], text: self.title).each do |music|
      self.add_music music
    end
    description = parsed.css('.VideoDescription-html')[0].inner_text
    CommonTag.included_tags(text: description).each do |tag|
      self.add_common_tag tag
    end
  end

  def self.default_order
    order(id: :desc)
  end

  def self.create_from_html(url:, body:)
    article = find_by_url(url)
    article.url = url
    article.html_data = body
    article.parse_html
    article.save!
  end

  private def update_count
    actor_tags.update_count
    music_tags.update_count
  end

  def self.set_music_ids
    self.where(music_id: nil).each do |article|
      article.update(music_id: article.music_tags.flat_map(&:musics).first.id)
    end
  end
end
