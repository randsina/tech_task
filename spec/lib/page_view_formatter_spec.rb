# frozen_string_literal: true

require_relative '../../lib/page_view_formatter'

RSpec.describe PageViewFormatter do
  describe '.format' do
    context 'when call with an empty data' do
      let(:page_view) do
        double(
          'PageView',
          context: 'visits',
          calculate: nil
        )
      end

      subject do
        described_class.format(resource: page_view)
      end

      it 'has an empty string' do
        expect(subject).to eq('')
      end
    end

    context 'with a valid data' do
      context 'for the most viewed pages' do
        let(:page_view) do
          double(
            'PageView',
            context: 'visits',
            calculate: {
              '/about' => 5,
              '/about/2' => 5,
              '/help_page/1' => 5,
              '/contact' => 4,
              '/index' => 1
            }
          )
        end

        let(:expected) do
          [
            '/about       5 visits',
            '/about/2     5 visits',
            '/help_page/1 5 visits',
            '/contact     4 visits',
            '/index       1 visits'
          ]
        end

        subject do
          described_class.format(resource: page_view)
        end

        it 'has a formatted result' do
          expect(subject).to eq(expected)
        end
      end

      context 'for the most unique viewed pages' do
        let(:unique_page_view) do
          double(
            'UniquePageView',
            context: 'unique views',
            calculate: {
              '/help_page/1' => 15,
              '/about' => 7,
              '/about/2' => 5,
              '/contact' => 4,
              '/index' => 1
            }
          )
        end

        let(:expected) do
          [
            '/help_page/1 15 unique views',
            '/about       7 unique views',
            '/about/2     5 unique views',
            '/contact     4 unique views',
            '/index       1 unique views'
          ]
        end

        subject do
          described_class.format(resource: unique_page_view)
        end

        it 'has a formatted result' do
          expect(subject).to eq(expected)
        end
      end
    end
  end
end
