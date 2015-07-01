require 'io/console'
require_relative 'player'
require_relative 'board'
# $stdin.getch
class Chess

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
  end

  def run
    until game_over?
      render_board
      select_piece
      move_piece
      switch_player
    end
    game_over_message
  end

  def game_over?
    false
  end

  def render_board
    @board.render
  end

  def select_piece
    pos_of_piece = cursor_movement
  end

  def move_piece
    pos_of_move = cursor_movement
  end

  def switch_player
    @players.reverse!
  end

  def game_over_message
    puts "Gmae is over!"
  end

  def get_cursor_input
    raise "Not yet written"
  end

  def cursor_movement
    while true
      key_press = STDIN.getch
      # check if it was \r, if it is  we do things(later)
      increment = key_press_coordinate(key_press)
      @board.move_cursor(increment)
      @board.render
      break if key_press == "\u0003"
      # return the cursor position if \r
      return @board.cursor_pos if key_press == "\r"
    end
  end

  def key_press_coordinate(string)
    case string
    when "w"
      return CURSOR_MOVEMENT[0]
    when "d"
      return CURSOR_MOVEMENT[1]
    when "s"
      return CURSOR_MOVEMENT[2]
    when "a"
      return CURSOR_MOVEMENT[3]
    when "\r"
      return CURSOR_MOVEMENT[4]
    end
  end

CURSOR_MOVEMENT = [[-1,0], [0,1], [1, 0], [0,-1], [0,0]]
end
