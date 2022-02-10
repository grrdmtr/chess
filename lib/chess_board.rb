# frozen_string_literal: true

require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'display'
require_relative 'player'

# ChessBoard class connects all chess pieces with the board together
# and includes methods for moving pieces

class ChessBoard
  include Display
  attr_accessor :board
  attr_reader :selected_chess, :winner

  def initialize
    @board = Array.new(8) { Array.new(8) }
    @selected_chess = ''
  end

  def initialize_board(player1, player2)
    initialize_first_row(0, player1)
    initialize_second_row(1, player1)
    initialize_second_row(6, player2)
    initialize_first_row(7, player2)
  end

  def initialize_first_row(index, player)
    color = player.color
    # Index should be 0 or 7
    @board[index] = [Rook.new([index, 0], color),
                     Knight.new([index, 1], color),
                     Bishop.new([index, 2], color),
                     Queen.new([index, 3], color),
                     King.new([index, 4], color),
                     Bishop.new([index, 5], color),
                     Knight.new([index, 6], color),
                     Rook.new([index, 7], color)]
  end

  def initialize_second_row(index, player)
    8.times do |column|
      @board[index][column] = Pawn.new([index, column], player.color)
    end
  end

  def show_board
    @board.each_with_index do |columns, row_index|
      print "\e[36m  #{8 - row_index} \e[0m"
      columns.each_with_index do |piece, column_index|
        update_board(piece, column_index, row_index)
      end
      puts ''
    end
    puts "\e[36m    a b c d e f g h \e[0m"
  end

  def update_board(piece, column_index, row_index)
    background = get_background(column_index, row_index)

    if selected_chess?(column_index, row_index)
      print "\e[46#{@selected_chess.push_unicode} \e[0m"
    elsif !piece.nil?
      print "\e[#{background}#{piece.push_unicode} \e[0m"
    else
      print "\e[#{background}m  \e[0m"
    end
  end

  def get_background(column_index, row_index)
    if row_index.even?
      return '47' if column_index.even?
      return '100' if column_index.odd?
    elsif row_index.odd?
      return '100' if column_index.even?
      return '47' if column_index.odd?
    else
      puts 'Error!'
    end
  end

  def convert_input(input)
    array = input.split('').reverse
    array[0] = (8 - array[0].to_i).to_i
    array[1] = convert_char(array[1]).to_i
    array
  end

  def convert_char(input)
    {
      'a' => '0',
      'b' => '1',
      'c' => '2',
      'd' => '3',
      'e' => '4',
      'f' => '5',
      'g' => '6',
      'h' => '7'
    }[input]
  end

  def select_chess(player, position)
    color = player.color
    array = convert_input(position)
    chess = @board[array[0]][array[1]]
    return @selected_chess = chess if !chess.nil? && chess.movable?(@board) && chess.color == color
  end

  def move_chess(player, position)
    choice = convert_input(position)
    if @selected_chess == ''
      select_chess_error
      false
    elsif !@selected_chess.movable_space.include?(choice)
      move_error(player.name)
      false
    elsif @selected_chess.movable_space.include?(choice)
      get_result(player, choice)
      true
    end
  end

  def get_result(player, new_position)
    old_position = @selected_chess.position
    promotion = @selected_chess.has_promotion
    @selected_chess.position = new_position
    if promotion && new_position[0].zero? && @selected_chess.color == 'black'
      choose_promotion
      @selected_chess = convert_chess(gets.chomp.upcase, new_position[0], new_position[1], 'black')
    elsif promotion && new_position[0] == 7 && @selected_chess.color == 'white'
      choose_promotion
      @selected_chess = convert_chess(gets.chomp.upcase, new_position[0], new_position[1], 'white')
    end
   unless @board[new_position[0]][new_position[1]].nil?
    status_update(player.name)
    checkmate?(new_position, player.name)
   end
    piece_submit(old_position, new_position)
  end

  def checkmate?(new_position, player)
    return @winner = player if @board[new_position[0]][new_position[1]].instance_of?(King)
  end

  def piece_submit(old_position, new_position)
    @board[new_position[0]][new_position[1]] = @selected_chess
    @board[old_position[0]][old_position[1]] = nil
    @selected_chess = ''
  end

  def convert_chess(input, index, color)
    {
      'R' => Rook.new([index, 7], color),
      'K' => Knight.new([index, 1], color),
      'B' => Bishop.new([index, 2], color),
      'Q' => Queen.new([index, 3], color)
    }[input]
  end

  def selected_chess?(column_index, row_index)
    return false if @selected_chess == ''
    return true if @selected_chess.position == [row_index, column_index]
  end
end
