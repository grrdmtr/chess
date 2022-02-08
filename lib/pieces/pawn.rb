class Pawn
  attr_accessor :position
  attr_reader :color, :has_promotion, :movable_space

  def initialize(position, color)
    @position = position
    @color = color
    @has_promotion = true
    @movable_space = []
  end

  def push_unicode
    return ";30m\u265F" if @color == 'black'
    return ";30m\u2659" if @color == 'white'
  end

  def movable?(board)
    feedback = false
    update_space(board)
    feedback = true unless @movable_space.size.zero?
    feedback
  end

  def update_space(board)
    row = @position[0]
    column = @position[1]
    case @color
    when 'white'
      @movable_space << [2, column] if row == 1 && board[2][column].nil?
      @movable_space << [3, column] if row == 1 && board[3][column].nil?
      @movable_space << [row + 1, column] if (row + 1).between?(0, 7) && board[row + 1][column].nil?
      @movable_space << [row + 1, column - 1] unless board[row + 1][column - 1].nil?
      @movable_space << [row + 1, column + 1] unless board[row + 1][column + 1].nil?
    when 'black'
      @movable_space << [5, column] if row == 6 && board[5][column].nil?
      @movable_space << [4, column] if row == 6 && board[4][column].nil?
      @movable_space << [row - 1, column] if (row - 1).between?(0, 7) && board[row - 1][column].nil?
      @movable_space << [row - 1, column - 1] unless board[row - 1][column - 1].nil?
      @movable_space << [row - 1, column + 1] unless board[row - 1][column + 1].nil?
    end
  end
end
