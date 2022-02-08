class Bishop
  attr_accessor :position
  attr_reader :color, :has_promotion, :movable_space

  def initialize(position, color)
    @position = position
    @color = color
    @has_promotion = false
    @moves = [[+1, -1], [-1, +1], [+1, +1], [-1, -1]]
    @movable_space = []
  end

  def push_unicode
    return ";30m\u265D" if @color == "black"
    return ";30m\u2657" if @color == "white"
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
      while row.between?(0, 7) && column.between?(0, 7)
        if board[row][column].nil?
          @movable_space << [row, column]
          row += move[0]
          column += move[1]
        elsif board[row][column].color != @color
          @movable_space << [row, column]
          break
        else
          break
        end
      end
    end
  end
end
