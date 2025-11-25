# frozen_string_literal: true

RSpec.describe NBTUtils::Reader do
  let(:fixture_path) { File.expand_path("../../../doc/#{fixture}", __FILE__) }
  let(:fixture) { 'test_uncompressed.nbt' }

  describe '#read' do
    shared_examples 'reads the NBT data' do
      it 'reads and returns the root tag', :aggregate_failures do
        expect(call.name).to eq('hello world')
        expect(call.payload.first.payload.value).to eq('Bananrama')
      end
    end

    context 'when given a StringIO' do
      let(:input) { StringIO.new(File.read(fixture_path)) }
      subject(:call) { described_class.new(input).read.tag }

      include_examples 'reads the NBT data'
    end

    context 'when given a String' do
      let(:input) { File.read(fixture_path) }
      subject(:call) { described_class.new(input).read.tag }

      include_examples 'reads the NBT data'
    end
  end
end
