#!/usr/bin/env ruby
# frozen_string_literal: true

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
  raise ArgumentError, 'File is missing'
end

log_extractor = LogExtractor.new(options)
log_extractor.read!

page_view = PageView.new(lines: log_extractor.lines)
page_view_output = PageViewFormatter.format(resource: page_view)
logger.puts(page_view_output)
logger.puts

unique_page_view = UniquePageView.new(lines: log_extractor.lines)
unique_page_view_output = PageViewFormatter.format(resource: unique_page_view)
logger.puts(unique_page_view_output)
