# frozen_string_literal: true

class PageView
  attr_reader :context

  def initialize(language:, lines:)
    @lines = lines
    @language = language
    @context = generate_context
  end

  def calculate
    @calculate ||= order(lines.transform_values(&:size))
  end

  private

  attr_reader :lines

  def order(lines)
    lines.sort_by { |_key, value| value }
         .reverse
  end

  def generate_context
    {
      'en' => 'visits',
      'ru' => 'визитов'
    }[@language]
  end
end
