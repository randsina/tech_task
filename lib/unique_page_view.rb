# frozen_string_literal: true

require_relative './page_view'

class UniquePageView < PageView
  def initialize(lines:)
    super
    @context = 'unique views'
  end

  def calculate
    @calculate ||=
      order(@lines.transform_values { |ip_addresses| ip_addresses.uniq.size })
  end
end
