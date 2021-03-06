class GameState

  attr_accessor :current_game, :board_state, :winning_move

  attr_reader :current_turn

  def initialize(game)
    self.current_game = game
    @current_turn = game.current_player_turn
    @winning_move = nil
  end

  def check_for_winning_move(turn)
    @winning_move = current_game.check_two(turn)
    @winning_move ? true : false
  end

  def analyze_state
    if current_game.finished?
      final_state_value
    end
  end

  def final_state_value
    return 0 if current_game.draw?
    current_game.winner == 1 ? 1 : -1 
  end

  def board_state
    current_game.board
  end

  def available_moves
    current_game.open_spaces
  end

  def make_move(input, player)
    current_game.set_player(input, player)
  end

  def first_moves(turn)
    if check_for_winning_move(turn)
      current_game.set_player(winning_move, turn) 
    elsif check_for_winning_move(turn + 1)
      current_game.set_player(winning_move, turn)
    end
  end

  def next_move
    unless first_moves(current_turn)
      current_game.set_player(available_moves.first, 1)
    end
  end

  def reset_winning_move
    self.winning_move = nil
  end

end