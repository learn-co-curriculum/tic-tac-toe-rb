require 'pry'

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(number)
  number = number.to_i
  index = number - 1
end

def move (board, index, value)
  board[index] = value
  board
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"? true: false
end

def valid_move?(board, index)
  taken = (board[index] == "X" || board[index] == "O"? true: false)

  valid = (taken == false && index <= 9 && index >= 0 ? true : false)

  valid
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
  else
    turn(board)
  end
end

def turn_count(board)
  turn_counter = 0
  board.each {|space| space == "X" || space == "O"? turn_counter += 1 : nil}
  turn_counter
end

def current_player(board)
  turn_counter = turn_count(board)

  turn_counter.even? ? "X" : "O"
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]

def won?(board)
  x_win_index = []
  o_win_index = []
  board.each_index {|i| board[i] == "X" ? x_win_index << i : nil}
  board.each_index {|i| board[i] == "O" ? o_win_index << i : nil}

  x_win_combo = []
  WIN_COMBINATIONS.each do |array|
    array.each {|number| x_win_index.include?(number) ? x_win_combo << number : nil}
    x_win_combo.length == 3 ? break : x_win_combo = []
  end

  o_win_combo = []
  WIN_COMBINATIONS.each do |array|
    array.each {|number| o_win_index.include?(number) ? o_win_combo << number : nil}
    o_win_combo.length == 3 ? break : o_win_combo = []
  end

  if x_win_combo.length == 3
    x_win_combo
  elsif o_win_combo.length == 3
    o_win_combo
  else
    false
  end
end

def full?(board)
  full_index = []
  board.each_index {|i| board[i] == "X" || board[i] == "O"? full_index << i : nil}
  full_index.length == 9 ? true : false
end

def draw?(board)
  full?(board) == true && won?(board) == false ? true : false
end

def over?(board)
  won = won?(board) != false ? true : false
  draw?(board) == true || won == true ? true : false
end

def winner(board)
  win_combo = won?(board)

  if win_combo == false
    nil
  elsif win_combo.all? {|i| board[i] == "X"} == true
    "X"
  elsif win_combo.all? {|i| board[i] == "O"} == true
    "O"
  end
end

def play(board)
  turn(board) until over?(board)

  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
