class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token = "X")
    @index = index
    @board[index] = token
  end

  def position_taken?(index_i)
    ((@board[index_i] == "X") || (@board[index_i] == "O"))
  end

  def valid_move?(board, index)
    @board = board
    @index = index
    index.between?(0,8) && !position_taken?(board, index)
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn(board)
    @board = board
    puts 'Please enter 1-9:'
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def won?(board)
    @board = board
    WIN_COMBINATIONS.detect do |i|
      board[i[0]] == "X" && board[i[1]] == "X" && board[i[2]] == "X" || board[i[0]] == "O" && board[i[1]] == "O" && board[i[2]] == "O"
    end
  end

  def full?(board)
    @board = board
    board.all? {|i| i == "X" || i == "O"}
  end

  def draw?(board)
    @board = board
    !won?(board) && full?(board)
  end

  def over?(board)
    @board = board
    won?(board) || draw?(board)
  end

  def winner(board)
    @board = board
    WIN_COMBINATIONS.detect do |i|
      if board[i[0]] == "X" && board[i[1]] == "X" && board[i[2]] == "X"
        return "X"
      elsif
        board[i[0]] == "O" && board[i[1]] == "O" && board[i[2]] == "O"
        return "O"
      end
    end
  end

  def play(board)
    turn(board) until over?(board)
    if won?(board)
      if winner(board) == "X"
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end
