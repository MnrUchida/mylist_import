class ArticlesDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?

  def decorator_class
    ArticleDecorator
  end

  def for_note
    self.map { |article| article.for_note }.join("\n\n")
  end
end
