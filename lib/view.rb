# frozen_string_literal: true

class View
  FORMAT_INDENT = 12

  def initialize(lines:)
    @lines = lines
    @context = 'visits'
  end

  def calculate
    @calculate ||= order(lines.transform_values(&:size))
  end

  def format
    return '' if @calculate.nil?

    calculate.map do |(page, count)|
      "#{page.ljust(FORMAT_INDENT)} #{count} #{context}"
    end
  end

  private

  attr_reader :lines, :context

  def order(lines)
    lines.sort_by { |_key, value| value }
         .reverse
  end
end
