require_relative '../lib/player.rb'

describe Player do
  subject(:test_player) {described_class.new}
  describe '#make_move' do
    before do
      allow(test_player).to receive(:valid_player_input?).and_return(false, false, true)
    end
    it 'loops 2 times when input wrong move twice and output error messe twice' do
      expect(test_player).to receive(:puts).exactly(5).times
      test_player.make_move
    end
  end

  describe '#valid_player_input?' do
    it 'returns false when the input is not number' do
      expect(test_player.valid_player_input?('da123 ads3')).to be false
    end

    it 'returns false when the input is number but out of range' do
      expect(test_player.valid_player_input?('23 3')).to be false
    end

    it 'returns true when the input is number and in range' do
      expect(test_player.valid_player_input?('3 3')).to be true
    end

    it 'update @x' do
      expect {test_player.valid_player_input?('3 3')}.to change{test_player.instance_variable_get(:@x)}.to(2)
    end

    it 'update @y' do
      expect {test_player.valid_player_input?('3 3')}.to change{test_player.instance_variable_get(:@y)}.to(2)
    end
  end
end