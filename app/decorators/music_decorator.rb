class MusicDecorator < ApplicationDecorator
  decorates_associations :articles

  def self.collection_decorator_class
    MusicsDecorator
  end

  def tag_names
    music_tags.map(&:name)
  end

  def articles_per_page
    @articles_per_page ||= object.articles.page(context[:page]).per(10)
  end

  def articles_count
    articles.size
  end
end
