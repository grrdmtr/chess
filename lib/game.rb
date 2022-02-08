# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'display'
require_relative 'player'
require_relative 'save_load'

class Game
  include Display
  include GameMemory

  def initialize(player1, player2)
    @game = ChessBoard.new
    @player1 = Player.new('white', player1)
    @player2 = Player.new('black', player2)
    @game.initialize_board(@player1, @player2)
    @current_player = @player1
    @winner = nil
    @game_instance = self
  end

  def start_game
    start_message
    input = gets.chomp.to_i
    case input
    when 1
      game_loop
    when 2
      load_game
    end
  end

  def game_loop
    start_message
    until winner?
      make_turn(@current_player)
      switch_player
      save_game(@game_instance) if save_game? == 1
    end
    case @game.show_board
    when 1
      start_game
    when 2
      load_game
    end
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

Game.new('Ash', 'Pikachu').start_game
