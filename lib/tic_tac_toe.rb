# represent the board as an array with 9 elements where " " represent an empty cell
# get users input via gets and player chooses a position by entering 1 - 9
# program will fill out specified position on the board with player's token
# keep track of player's turn
# check to see, at every turn, if there's a winner
#  if winner, congratulate or if tie, inform the players

class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # First column
    [1,4,7], # Middle column
    [2,5,8], # Last column
    [0,4,8], # Left diagonal
    [2,4,6]  # Right diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
  input = input.to_i - 1
  end

  def move(input, value = "X")
  @board[input] = value
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn
    puts "Please enter a number between 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Position taken...try again..."
      turn
    end
  end

  def turn_count
    turn = 0
    @board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end
    return turn
  end

  def current_player
  turn = turn_count
    turn = turn.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.any? do |index|
      if index.all? { |i| @board[i] == "X" }
      return index
    elsif index.all? { |i| @board[i] == "O"}
      return index
    end
  end
    false
  end

  def full?
    @board.all? do |i|
    i == "X" || i == "O"
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if w = won?
      @board[w.first]
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
