# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'display'
require_relative 'player'

class Game
  include Display

  def initialize(player1, player2)
    @game = ChessBoard.new
    @player1 = Player.new('white', player1)
    @player2 = Player.new('black', player2)
    @game.initialize_board(@player1, @player2)
    @current_player = @player1
    @winner = nil
    game_loop
  end

  def game_loop
    start_message
    until winner?
      make_turn(@current_player)
      switch_player
    end
    @game.show_board
    game_over(@winner)
  end

  def make_turn(player)
    @game.show_board
    get_input_chess(player.name)
    input = gets.chomp
    @game.select_chess(player, input)
    @game.show_board
    get_input_move(player.name)
    input = gets.chomp
    until @game.move_chess(player, input)
      input = gets.chomp
      @game.select_chess(player, input)
    end
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def winner?
    @winner = @game.winner
  end
end

Game.new('Ash', 'Pikachu')
