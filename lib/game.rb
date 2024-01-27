require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

class Game 
  def initialize(player1 = Player.new('r'), player2 = Player.new('b'), game_board = Board.new)
    @player1 = player1
    @player2 = player2
    @game_board = game_board
    @turn1 = true

  end

  def game_play
    not_end_game = true
    while not_end_game do
      @game_board.print_board
      player = @turn1 ? @player1 : @player2
      loop do
        player.make_move 
        break if @game_board.valid_move?(player.x, player.y) 
      end
      @game_board.change_board(player.x, player.y, player.color)
      if @game_board.check_win_for_move(player.x, player.y)
        puts "Player with color #{player.color == 'r' ? 'red' : 'black'} wins the game"
        @game_board.print_board 
        return
      end
      @turn1 = @turn1 ? false : true
    end
  end
end

game = Game.new
game.game_play