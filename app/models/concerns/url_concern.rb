module UrlConcern
  extend ActiveSupport::Concern

  included do
    before_validation :set_code
  end

  module ClassMethods
    def code_from_url(url)
      URI.parse(url).path.split('/').last
    end

    private def find_by_url(url)
      find_or_initialize_by(code: code_from_url(url))
    end
  end

  private def set_code
    self.code = self.class.code_from_url(self.url)
  end
end
