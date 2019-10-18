# frozen_string_literal: true

require 'optparse'
Dir['./lib/*.rb'].each { |file| require file }

class App
  class << self
    def execute!(logger = $stdout)
      @@logger = logger
      options = parse_options!

      log_extractor = LogExtractor.new(options.slice(:filepath))
      log_extractor.read!

      page_view = PageView.new(language: options[:language], lines: log_extractor.lines)
      page_view_output = PageViewFormatter.format(resource: page_view)
      logger.puts(page_view_output)
      logger.puts

      unique_page_view = UniquePageView.new(language: options[:language], lines: log_extractor.lines)
      unique_page_view_output = PageViewFormatter.format(resource: unique_page_view)
      logger.puts(unique_page_view_output)
    end

    private

    def logger
      @@logger
    end

    def parse_options!
      ARGV << '-h' if ARGV.empty?
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: app.rb [options] or app.rb <filepath>'

        opts.on('-fFILE', '--file=FILE', 'File with logs') do |file|
          options[:filepath] = file
        end

        opts.on('-h', '--help', 'Prints this help') do
          logger.puts opts
          exit
        end

        opts.on('-lLANGUAGE', '--language=LANGUAGE', 'Prints in your language') do |language|
          options[:language] = language
        end
      end.parse!

      options[:filepath] ||= ARGV.first
      if options[:filepath].nil? || options[:filepath].empty?
        raise ArgumentError, 'File is missing'
      end

      if options[:language].nil? || options[:language].empty?
        options[:language] = 'en'
      end

      options
    end
  end
end
