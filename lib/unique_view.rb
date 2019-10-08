# frozen_string_literal: true

require_relative './view'

class UniqueView < View
  def initialize(lines:)
    super
    @context = 'unique views'
  end

  def calculate
    @calculate ||=
      order(@lines.transform_values { |ip_addresses| ip_addresses.uniq.size })
  end
end
