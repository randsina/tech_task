# frozen_string_literal: true

require_relative '../../lib/page_view'

RSpec.describe PageView do
  describe '#initialize' do
    let(:lines) { { 'about' => ['1.1.1.1'] } }

    subject do
      described_class.new(lines: lines)
    end

    it 'has a correct context' do
      expect(subject.instance_variable_get('@context')).to eq('visits')
    end
  end

  describe '#calculate' do
    context 'with an empty lines' do
      let(:lines) { {} }

      subject do
        described_class.new(lines: lines)
      end

      it 'comes back an blank result' do
        expect(subject.calculate).to eq([])
      end
    end

    context 'with a valid data' do
      let(:lines) do
        {
          '/help_page/1' => ['184.123.665.067', '158.577.775.616', '543.910.244.929', '158.577.775.616', '682.704.613.213'],
          '/contact' => ['836.973.694.403', '016.464.657.359', '682.704.613.213', '682.704.613.213'],
          '/index' => ['158.577.775.616'],
          '/about/2' => ['802.683.925.780', '200.017.277.774', '126.318.035.038', '451.106.204.921', '235.313.352.950'],
          '/about' => ['016.464.657.359', '061.945.150.735', '802.683.925.780', '543.910.244.929', '543.910.244.929']
        }
      end
      let(:expected) do
        [
          ['/about', 5],
          ['/about/2', 5],
          ['/help_page/1', 5],
          ['/contact', 4],
          ['/index', 1]
        ]
      end

      subject do
        described_class.new(lines: lines)
      end

      it 'has a blank result' do
        expect(subject.calculate).to eq(expected)
      end
    end
  end

  describe '#format' do
    context 'when call before #calculate' do
      let(:lines) do
        {
          '/help_page/1' => ['184.123.665.067'],
          '/contact' => ['836.973.694.403', '016.464.657.359'],
          '/index' => ['158.577.775.616']
        }
      end

      subject do
        described_class.new(lines: lines)
      end

      it 'has an empty string' do
        expect(subject.format).to eq('')
      end
    end

    context 'with a valid data' do
      let(:lines) do
        {
          '/help_page/1' => ['184.123.665.067', '158.577.775.616', '543.910.244.929', '158.577.775.616', '682.704.613.213'],
          '/contact' => ['836.973.694.403', '016.464.657.359', '682.704.613.213', '682.704.613.213'],
          '/index' => ['158.577.775.616'],
          '/about/2' => ['802.683.925.780', '200.017.277.774', '126.318.035.038', '451.106.204.921', '235.313.352.950'],
          '/about' => ['016.464.657.359', '061.945.150.735', '802.683.925.780', '543.910.244.929', '543.910.244.929']
        }
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
        described_class.new(lines: lines)
      end

      before { subject.calculate }

      it 'has a blank result' do
        expect(subject.format).to eq(expected)
      end
    end
  end
end
