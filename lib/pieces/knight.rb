class Knight
  attr_accessor :position
  attr_reader :color, :has_promotion, :movable_space

  def initialize(position, color)
    @position = position
    @color = color
    @has_promotion = false
    @moves = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
    @movable_space = []
  end

  def push_unicode
    return ";30m\u265E" if @color == 'black'
    return ";30m\u2658" if @color == 'white'
  end

  def movable?(board)
    feedback = false
    update_space(board)
    feedback = true unless @movable_space.size.zero?
    feedback
  end

  def update_space(board)
    @moves.each do |move|
      row = @position[0] + move[0]
      column = @position[1] + move[1]
      next unless row.between?(0, 7) && column.between?(0, 7)

      position = board[row][column]
      @movable_space << [row, column] if position.nil? || @color != position.color
    end
  end
end
