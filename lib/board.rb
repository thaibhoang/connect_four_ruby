class Board
  attr_accessor :board
  def initialize(rows = 6, cols = 7, board = make_board())
    @rows = rows
    @cols = cols
    @board = board
  end

  def make_board
    Array.new(6).map {|row| row = Array.new(7, '*')}
  end

  def change_board(x, y, color)
    @board[x][y] = color if valid_move?(x, y) 
  end

  def valid_move?(x, y)
    if !(x.between?(0, 5) && y.between?(0,6)) || @board[x][y] != '*' || (x != 0 && @board[x - 1][y] == '*')
      puts "Invalid! Remember that your move need to have a cel above it already played"
      return false
    end
    return true
  end

  def check_win_for_move(x, y)
    color = @board[x][y]
    return false if color == '*'
    left_fomular = [0, -1]
    right_fomular = [0, 1]
    up_fomular = [1, 0]
    down_fomular = [-1, 0]
    up_left_fomular = [-1, 1]
    up_right_fomular = [1, 1]
    down_left_fomular = [-1, -1]
    down_right_fomular = [1, -1]
    def helper(x, y, fomular, count, color)
      return count if count >= 3
      if (x + fomular[0]).between?(0, 6) && (y + fomular[1]).between?(0, 7) && @board[x + fomular[0]][y + fomular[1]] == color
        return helper(x + fomular[0], y + fomular[1], fomular, count + 1, color)
      end
      return count
    end
    row = helper(x, y, left_fomular, 0, color) + helper(x, y, right_fomular, 0, color)
    col = helper(x, y, up_fomular, 0, color) + helper(x, y, down_fomular, 0, color)
    diag1 = helper(x, y, up_left_fomular, 0, color) + helper(x, y, down_right_fomular, 0, color)
    diag2 = helper(x, y, up_right_fomular, 0, color) + helper(x, y, down_left_fomular, 0, color)
    return true if row >= 3 || col >= 3 || diag1 >=3 || diag2 >= 3
    return false
  end

  def print_board
    puts
    puts "     1 2 3 4 5 6 7   "
    puts "  || ~~~~~~~~~~~~~ ||"
    for i in 0..5
      print "#{i+1} || "
      for j in 0..6
        print "#{@board[i][j]} "
      end
      puts "||"
    end
  end
end



