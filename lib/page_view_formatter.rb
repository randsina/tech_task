# frozen_string_literal: true

class PageViewFormatter
  FORMAT_INDENT = 12

  class << self
    def format(resource:)
      return '' if resource&.calculate.nil?

      resource.calculate.map do |(page, count)|
        "#{page.ljust(FORMAT_INDENT)} #{count} #{resource.context}"
      end
    end
  end
end
