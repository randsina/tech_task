# frozen_string_literal: true

class PageView
  attr_reader :context

  def initialize(lines:)
    @lines = lines
    @context = 'visits'
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
end
