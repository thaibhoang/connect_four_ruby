require_relative '../lib/board.rb'

describe Board do
  subject(:game_board) { described_class.new }

  describe "#make_board" do
    before do
      game_board.make_board
    end
    it 'make a board with 6 rows' do
      expect(game_board.instance_variable_get(:@board).size).to be 6      
    end
    it 'make a board with 7 columns' do
      expect(game_board.instance_variable_get(:@board)[0].size).to be 7
    end
  end 

  describe '#change_board' do
    before do
      allow(game_board).to receive(:valid_move?).and_return(true, false)
    end
    it "change the cel in the board when it is a valid move" do
      game_board.change_board(5, 3, 'red')
      expect(game_board.board[5][3]).to eq 'red'  
      game_board.change_board(5, 4, 'red') 
      expect(game_board.board[5][4]).not_to eq 'red'     
    end
  end

  describe '#valid_move?' do
    it "returns false when the x or y out of the board size" do
      expect(game_board.valid_move?(-1, 5)).to be false
    end

    it "returns false when the position has been played" do
      expect(game_board.valid_move?(3, 3)).to be false
    end

    it "returns false when the position has not been played but not above the base line or above another played cel (rules of the game)" do
      expect(game_board.valid_move?(5, 3)).to be false
    end
  end

  describe '#check_win_for_move' do
    before do
      game_board.change_board(0, 0, 'r')
      game_board.change_board(0, 1, 'r')
      game_board.change_board(0, 2, 'r')
      game_board.change_board(0, 3, 'r')
      game_board.change_board(1, 0, 'r')
      game_board.change_board(2, 0, 'r')
      game_board.change_board(3, 0, 'r')
      game_board.board[1][1] = 'r'
      game_board.board[2][2] = 'r'
      game_board.board[3][3] = 'r'
    end
    it 'return true when there are four consecutive red in row 0' do
      expect(game_board.check_win_for_move(0, 3)).to be true
    end

    it 'return true when there are four consecutive red in col 0' do
      expect(game_board.check_win_for_move(3, 0)).to be true
    end

    it 'return true when there are four consecutive red in diagonal' do
      expect(game_board.check_win_for_move(3, 3)).to be true
    end

    it 'return false when there are no four consecutive cel' do
      game_board.print_board
      expect(game_board.check_win_for_move(3, 4)).to be false
    end
  end
  describe '#print_board' do
    it "print the board" do
      game_board.print_board
    end
  end
end