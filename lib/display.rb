module Display
  def start_message
    puts "
    Let's play Chess!

    input 1 to play new game with human,
    input 2 to play a saved game.
    "
  end

  def set_player1_name
    puts "
    Please input player one's name.
    "
  end

  def set_player2_name
    puts "
    Please input player two's name.
    "
  end

  def input_error
    puts '
    Invalid input!

    Please input again.
    '
  end

  def select_chess_error
    puts '
    Invalid input!

    Choose valid chess.
    '
  end

  def move_error(player)
    puts "
    #{player}, you made an invalid move!

    Please make a valid move.
   "
  end

  def choose_promotion
    puts "
    This pawn needs promotion,
    please input 'b' for bishop, 'k' for knight,
    'r' for rook, and 'q' for queen.
    "
  end

  def status_update(winner)
    puts "
    #{winner} took enemy's chess
    "
  end

  def get_input_chess(player)
    puts "
    #{player} Select your chess.
    "
  end

  def get_input_move(player)
    puts "
    #{player} Make your move, or press 1 if you want to save the game
    "
  end

  def game_over(winner_name)
    puts "
    #{winner_name} wins!
    Play again?
    input 1 to start a new game
    input 2 to load a saved game
    input other to quit
    "
    gets.chomp.to_i
  end

  def save_game?
    puts '
    Press 1 if you want to save the game
    '
    gets.chomp.to_i
  end
end
