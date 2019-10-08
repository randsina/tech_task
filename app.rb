#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require 'optparse'
Dir['./lib/*.rb'].each { |file| require file }

logger = $stdout

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: app.rb [options] or app.rb <filepath>'

  opts.on('-fFILE', '--file=FILE', 'File with logs') do |file|
    options[:filepath] = file
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

options[:filepath] ||= ARGV.first
if options[:filepath].nil? || options[:filepath].empty?
  raise ArgumentError, 'File is missed'
end

log_reader = LogReader.new(options)
log_reader.read!

views = View.new(lines: log_reader.lines)
views.calculate
logger.puts(views.format)
logger.puts

unique_views = UniqueView.new(lines: log_reader.lines)
unique_views.calculate
logger.puts(unique_views.format)
