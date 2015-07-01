require_relative 'EmptySquare'
require_relative 'piece'
require 'colorize'

class Board
  attr_accessor :cursor_pos

  def initialize
    @grid = Array.new(8) {Array.new(8) {EmptySquare.new}}
    self.populate
    @cursor_pos = [0,0]
  end

  def render
    system ("clear")
    puts # spacer
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, square_idx|
        if [row_idx, square_idx] == @cursor_pos
          print " #{square.icon} ".colorize(:color => :blue, :background => :light_green)
        elsif (square_idx + row_idx).even?
          print " #{square.icon} ".colorize(:color => :blue, :background => :light_white)
        else
          print " #{square.icon} ".colorize(:color => :blue, :background => :light_black)
        end

      end
      puts
    end
    puts # spacer
  end

  def populate
    #change @grid to contain instances of all pieces
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, square_idx|
        start_position = [row_idx, square_idx]
        if row_idx == 0
          # populate with black pieces, non-pawns
          case square_idx
          when 0, 7
            @grid[row_idx][square_idx] = Rook.new(start_position, :black, self)
          when 1, 6
            @grid[row_idx][square_idx] = Knight.new(start_position, :black, self)
          when 2, 5
            @grid[row_idx][square_idx] = Bishop.new(start_position, :black, self)
          when 3
            @grid[row_idx][square_idx] = King.new(start_position, :black, self)
          when 4
            @grid[row_idx][square_idx] = Queen.new(start_position, :black, self)
          end
        elsif row_idx == 1
          # populate with black pieces, pawns
          @grid[row_idx][square_idx] = Pawn.new(start_position, :black, self)
        elsif row_idx == 6
          # populate with white pieces, pawns
          @grid[row_idx][square_idx] = Pawn.new(start_position, :white, self)
        elsif row_idx == 7
          # populate with white pieces, non-pawns
          case square_idx
          when 0, 7
            @grid[row_idx][square_idx] = Rook.new(start_position, :white, self)
          when 1, 6
            @grid[row_idx][square_idx] = Knight.new(start_position, :white, self)
          when 2, 5
            @grid[row_idx][square_idx] = Bishop.new(start_position, :white, self)
          when 3
            @grid[row_idx][square_idx] = King.new(start_position, :white, self)
          when 4
            @grid[row_idx][square_idx] = Queen.new(start_position, :white, self)
          end
        end
      end
    end


  end

  def move_cursor(increment)
    r,c = increment
    @cursor_pos = [(@cursor_pos[0] + r), (@cursor_pos[1] + c)]
  end
end
