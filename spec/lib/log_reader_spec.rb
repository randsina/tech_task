# frozen_string_literal: true

require_relative '../../lib/log_reader'

RSpec.describe LogReader do
  describe '#initialize' do
    let(:filepath) { 'webserver.log' }

    subject do
      described_class.new(filepath: filepath)
    end

    it 'initializes with a filepath' do
      expect(subject.instance_variable_get('@filepath')).to eq(filepath)
    end
  end

  describe '#read!' do
    context 'with a valid filename' do
      context 'with a correct format of logs' do
        let(:filepath) { 'spec/fixtures/small_webserver.log' }
        let(:expected) do
          {
            '/help_page/1' => ['184.123.665.067', '158.577.775.616', '543.910.244.929', '158.577.775.616', '682.704.613.213'],
            '/contact' => ['836.973.694.403', '016.464.657.359', '682.704.613.213', '682.704.613.213'],
            '/index' => ['158.577.775.616'],
            '/about/2' => ['802.683.925.780', '200.017.277.774', '126.318.035.038', '451.106.204.921', '235.313.352.950'],
            '/about' => ['016.464.657.359', '061.945.150.735', '802.683.925.780', '543.910.244.929', '543.910.244.929']
          }
        end

        subject do
          described_class.new(filepath: filepath)
        end

        before { subject.read! }

        it 'reads file by lines' do
          expect(subject.lines).to eq(expected)
        end
      end
    end

    context "when file doesn't exist" do
      let(:filepath) { 'spec/fixtures/file_not_found.log' }

      subject do
        described_class.new(filepath: filepath)
      end

      it 'raises error that file not found' do
        expect { subject.read! }.to raise_error.with_message(/not found/)
      end
    end

    context 'when file contains incorrect lines' do
      let(:filepath) { 'spec/fixtures/incorrect_data.log' }

      subject do
        described_class.new(filepath: filepath)
      end

      it 'raises error that data is corrupted' do
        expect { subject.read! }.to raise_error.with_message(/not valid/)
      end
    end
  end
end
