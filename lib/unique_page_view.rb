# frozen_string_literal: true

require_relative './page_view'

class UniquePageView < PageView
  def initialize(language:, lines:)
    super
  end

  def calculate
    @calculate ||=
      order(@lines.transform_values { |ip_addresses| ip_addresses.uniq.size })
  end

  def generate_context
    {
      'en' => 'unique views',
      'ru' => 'уникальных визитов'
    }[@language]
  end
end
