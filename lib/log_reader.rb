# frozen_string_literal: true

class LogReader
  LINE_REGEX = %r{
    ^
    ([a-zA-Z\/\d_]+)                     # simplified path
    \s                                   # whitespace
    (\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) # ip address
    $
  }x.freeze

  attr_reader :lines

  def initialize(filepath:)
    @filepath = filepath
    @lines = Hash.new { |hash, key| hash[key] = [] }
  end

  def read!
    check_file_exists!
    IO.foreach(filepath).lazy.each_with_index do |line, index|
      line.strip!
      validate_line(line, index)
      add_line(line)
    end
  end

  private

  attr_reader :filepath

  def check_file_exists!
    raise IOError, 'File not found' unless File.exist?(filepath)
  end

  def add_line(line)
    path, ip_address = line.split(' ')
    lines[path] << ip_address
  end

  def validate_line(line, index)
    return if line.match?(LINE_REGEX)

    raise RegexpError, "Line ##{index} '#{line}' is not valid"
  end
end
