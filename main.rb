require 'colorize'
require 'byebug'
require_relative 'player'
require_relative 'question'

#REPL + game logic
@repl_bool = true
#0 for p1 1 for p2
@turn = 0

puts "Welcome to ruby_math_game (OOP edition)"
puts

print 'Player 1 name: '
@username = gets.chomp
p1 = Player.new(@username)
p1.name = p1.name.colorize(:magenta)
print 'Player 2 name: '
@username = gets.chomp
p2 = Player.new(@username)
p2.name = p2.name.colorize(:magenta)

puts
puts "Alright then, let us begin."
puts

while @repl_bool
  
  question = Question.new

  case @turn
  when 0
    print "#{p1.name}: "
  else 
    print "#{p2.name}: "
  end

  print question.to_string
  @user_input = gets.chomp.to_i

  if @turn == 0 && question.is_correct?(@user_input)
    puts "CORRECT!".colorize(:blue)
    p1.gain_point
    @turn += 1
  elsif @turn == 0 && !question.is_correct?(@user_input)
    puts "WRONG!".colorize(:red)
    p1.lose_life
    @turn += 1
  elsif @turn == 1 && question.is_correct?(@user_input)
    puts "CORRECT!".colorize(:blue)
    p2.gain_point
    @turn -= 1
  elsif @turn == 1 && !question.is_correct?(@user_input)
    puts "WRONG!".colorize(:red)
    p2.lose_life
    @turn -= 1
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

    @repl_bool = false
  end

end