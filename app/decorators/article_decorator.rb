class ArticleDecorator < ApplicationDecorator
  def self.collection_decorator_class
    ArticlesDecorator
  end

  def link_to_prev
    return if self.prev.blank?

    h.link_to "Prev", h.article_path(self.prev)
  end

  def link_to_next
    return if self.next.blank?

    h.link_to "Next", h.article_path(self.next)
  end

  def for_twitter
    <<~EOS
      #{note}

      #{title} https://nico.ms/#{code}?ref=twitter ##{code} #ニコニコ動画
    EOS
  end

  def for_note
    <<~EOS
      ### #{title}

      #{note}

       https://nico.ms/#{code}
    EOS
  end
end
