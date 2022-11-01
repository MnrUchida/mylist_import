module TagConcern
  extend ActiveSupport::Concern

  included do
    scope :by_names, ->(value) { where(name: value) }
    scope :not_by_names, ->(value) { where.not(name: value) }

    before_validation :name_convert
  end

  module ClassMethods
    def create_not_exist_data(values)
      exist_data = self.where(name: values)
      insert_data = values.reject { |value| exist_data.any? {|data| data.name == value } }.map { |value| { name: value } }
      insert_all(insert_data) if insert_data.present?
    end

    def included_tags(initial: [], text:)
      tags = []
      converted_text = initial.inject(text) { |result, pattern| result.gsub(pattern, "\n") }
      self.order('length(name) DESC').pluck(:name).inject(converted_text) do |result, pattern|
        tags << pattern if result.include?(pattern)
        result.gsub(pattern, "\n")
      end
      tags
    end
  end

  private def name_convert
    self.name = self.name.unicode_normalize.tr('０-９ａ-ｚＡ-Ｚ／　', '0-9a-zA-Z/ ')
  end
end
