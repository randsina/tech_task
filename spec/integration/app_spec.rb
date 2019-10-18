# frozen_string_literal: true

require 'tempfile'
require_relative '../../app'

RSpec.describe App do
  describe '.execute!' do
    let(:logger) { StringIO.new }

    context 'with a passed log file' do
      let(:file) do
        file = Tempfile.new('webserver.log')
        file.write("/help_page/1 543.910.244.929\n/about/2 802.683.925.780")
        file.rewind
        file
      end
      let(:expected) do
        <<~OUTPUT
          /about/2     1 visits
          /help_page/1 1 visits

          /about/2     1 unique views
          /help_page/1 1 unique views
        OUTPUT
      end

      context 'as a main argument' do
        it 'writes results in the logger' do
          ARGV.replace [file.path]
          described_class.execute!(logger)
          logger.rewind
          expect(logger.read).to eq(expected)
        end
      end

      context 'as a --file argument' do
        it 'writes results in the logger' do
          ARGV.replace ['--file', file.path]
          described_class.execute!(logger)
          logger.rewind
          expect(logger.read).to eq(expected)
        end
      end
    end

    context 'without correct log file' do
      it 'raises error' do
        ARGV.replace ['-f', '']
        runner = -> { described_class.execute!(logger) }
        expect(runner).to raise_error(ArgumentError, 'File is missing')
      end
    end

    context 'with --help argument' do
      it 'shows a help page' do
        ARGV.replace ['--help']
        runner = -> { described_class.execute!(logger) }
        expect(runner).to raise_error(SystemExit)
        logger.rewind
        expect(logger.read).to match(/Prints this help/)
      end
    end

    context 'with -l argument' do
      let(:file) do
        file = Tempfile.new('webserver.log')
        file.write("/help_page/1 543.910.244.929\n/about/2 802.683.925.780")
        file.rewind
        file
      end
      let(:expected) do
        <<~OUTPUT
          /about/2     1 визитов
          /help_page/1 1 визитов

          /about/2     1 уникальных визитов
          /help_page/1 1 уникальных визитов
        OUTPUT
      end

      it 'shows a page with russian language' do
        ARGV.replace ['-l', 'ru', '-f', file.path]
        described_class.execute!(logger)
        logger.rewind
        expect(logger.read).to eq(expected)
      end
    end
  end
end
