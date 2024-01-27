class Player

  attr_accessor :x, :y, :color
  def initialize(color)
    @x
    @y
    @color = color
  end

  def make_move
    loop do
      puts 'Type in the position x (between 1 and 6) and y (between 1 and 7), separate by a space'
      input = gets.chomp
      break if valid_player_input?(input) 
      puts 'Wrong type of input!'    
    end
  end

  def valid_player_input?(input)
    return false if !input.match(/^\d+\s+\d+$/)
    arr = input.split(" ")
    x, y = arr[0].to_i, arr[1].to_i
    return false if !(x.between?(1, 6) && y.between?(1, 7))
    @x, @y = x - 1, y - 1
    return true
  end

end