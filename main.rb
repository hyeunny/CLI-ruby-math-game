require 'colorize'
require 'byebug'
require_relative 'player'
require_relative 'question'

#REPL + game logic
@game_started = true
#0 for p1 1 for p2
@turn = 0

puts "Welcome to ruby_math_game (OOP edition)"
puts

# Ask the user to enter a player name
# Create the player object
# Return the player object for the new player
def create_player(player_count)
  print "Player #{player_count} name: "
  username = gets.chomp
  player = Player.new(username)
  player.name = player.name.colorize(:magenta)
  player
end

def switch_turn
  if @turn == 1
    @turn = 0
  else
    @turn = 1
  end
  # Same as using ternary operator
  # @turn = @turn == 1 ? 0 : 1
end

def current_player
  # get current player... based on current @turn
end

# Returns true if the current player answered correctly
def current_player_correct?

end

p1 = create_player(1)
p2 = create_player(2)

puts
puts "Alright then, let us begin."
puts

while @game_started
  
  question = Question.new

  case @turn
  when 0
    print "#{p1.name}: "
  else 
    print "#{p2.name}: "
  end

  print question  # automatically calls to_s for you
  @user_input = gets.chomp.to_i

  # get current player

  # check their answer
  if @turn == 0 && question.is_correct?(@user_input)
    puts "CORRECT!".colorize(:blue)
    p1.gain_point
    switch_turn
  elsif @turn == 0 && !question.is_correct?(@user_input)
    puts "WRONG!".colorize(:red)
    p1.lose_life
    switch_turn
  elsif @turn == 1 && question.is_correct?(@user_input)
    puts "CORRECT!".colorize(:blue)
    p2.gain_point
    switch_turn
  elsif @turn == 1 && !question.is_correct?(@user_input)
    puts "WRONG!".colorize(:red)
    p2.lose_life
    switch_turn
  end

  puts
  puts "The score so far:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} REMAINING LIVES 
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} REMAINING LIVES"
  puts

  if p1.lives < 1 || p2.lives <1
    puts "Game OVER."
    if p1.lives < 1
      puts "The winner is #{p2.name}"
    elsif p2.lives < 1
      puts "The winner is #{p1.name}"
    end

    puts "The final score was:
        #{p1.name}: #{p1.correct_answers} CORRECT ANSWERS #{p1.lives} REMAINING LIVES 
        #{p2.name}: #{p2.correct_answers} CORRECT ANSWERS #{p2.lives} REMAINING LIVES"

    @game_started = false
  end

end