#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pry'
require 'optparse'
Dir['./lib/*.rb'].each { |file| require file }

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
