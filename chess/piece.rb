class Piece
  attr_reader :icon

  def initialize(start_position = nil, color = :black, reference_board)
    @icon = "Ҏ"
    @current_position = start_position
    @color = color
    @reference_board = reference_board
  end

  def moves
    #should return an array of places a piece can move to
    r, c = @current_position

    diagonals = []
    r_up, r_down, l_down, l_up = [], [], [], []
    (1..7).each do |num|
      l_up << [r - num, c - num]
      r_up << [r - num, c + num]
      r_down << [r + num, c + num]
      l_down << [r + num, c - num]
    end
    diagonals << r_up << r_down << l_down << l_up
    diagonals.each do |direction_array|
      direction_array.select! do |pairs|
        (0..7).include?(pairs[0]) && (0..7).include?(pairs[1])
      end
    end

    vertical_horizontal = []
    up, down, left, right = [], [], [], []
    # (1..7).each do |num|
    #   vertical_horizontal << [r, c - num] << [r, c + num] << [r + num, c] << [r - num, c]
    # end
    (1..7).each do |num|
      up << [r - num, c]
      down << [r + num, c]
      left << [r, c - num]
      right << [r, c + num]
    end
    vertical_horizontal << up << right << down << left
    vertical_horizontal.each do |direction_array|
      direction_array.select! do |pairs|
        (0..7).include?(pairs[0]) && (0..7).include?(pairs[1])
      end
    end

    l_step = [  [r - 2, c + 1],
                [r - 1, c + 2],
                [r + 1, c + 2],
                [r + 2, c + 1],
                [r + 2, c - 1],
                [r + 1, c - 2],
                [r - 1, c - 2],
                [r - 2, c - 1]  ]
    l_step.select! {|pairs| (0..7).include?(pairs[0]) && (0..7).include?(pairs[1]) }

    [diagonals, vertical_horizontal, l_step]
    # diagonals = [[diag-up-r], [], [], []]
    # diag-up-r = [[x,y], [x1,y1]]
  end

  def empty?
    false
  end

end

##############################################

class SlidingPiece < Piece

  def moves
    possible_moves = super.take(2)
  end
end

class SteppingPiece < Piece

  def moves
    super
  end
end

##############################################

class King < SteppingPiece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♛"
    elsif @color == :white
      @icon = "♕"
    end
  end

  def moves
    r, c = @current_position
    possible_moves = super.take(2).flatten(2)
    possible_moves.select! do |position_pairs|
      position_pairs[0] <= r + 1 && position_pairs[1] <= r + 1
    end
    possible_moves
  end


end

class Queen < SlidingPiece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♚"
    elsif @color == :white
      @icon = "♔"
    end
  end

  def moves
    all_possible_moves = super.flatten(1)
    direction_arr = directional_array(all_possible_moves)
    # all_possible_moves = valid_moves(direction_arr)
    #check if something is blocking the path
    all_possible_moves.flatten(1)
  end

  def directional_array(moves_arr)
    direction_arr = moves_arr.select { |sub_arr| !sub_arr.empty? }
    direction_arr # returns [[r_up], [r_down]... ]
  end

end

class Bishop < SlidingPiece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♝"
    elsif @color == :white
      @icon = "♗"
    end
  end

  def moves
    possible_moves = super.take(1)
    possible_moves
  end


end

class Knight < SteppingPiece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♞"
    elsif @color == :white
      @icon = "♘"
    end
  end

  def moves
    possible_moves = super.last
    possible_moves
  end


end

class Rook < SlidingPiece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♜"
    elsif @color == :white
      @icon = "♖"
    end
  end

  def moves
    possible_moves = super[1]
    possible_moves
  end


end

class Pawn < Piece
  def initialize(start_position, color)
    super(start_position, color)
    assign_icon
  end

  def assign_icon
    if @color == :black
      @icon = "♟"
    elsif @color == :white
      @icon = "♙"
    end
  end

  def moves
    #depends on color
    #depends on current position since it can move 2 spaces atfirst
    #only moves forward, will not return to start_position
  end

end


# ♜	♞	♝	♛	♚	♝	♞	♜
# ♟	♟	♟	♟	♟	♟	♟	♟
# ♙	♙	♙	♙	♙	♙	♙	♙
# ♖	♘	♗	♕	♔	♗	♘	♖
