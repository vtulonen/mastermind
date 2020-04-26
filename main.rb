require 'byebug'
require './Game.rb'




class Player
  def initialize(name)
    @name = name
  end
    
  def name
    @name
  end

  def enter_code_row
    print "Your guess: "
    while true
    input = gets.chomp.upcase!
      if input.match(/[GOPBYR]/i) && input.length == 4
        return input.split('')
      else 
        print '   #  Try again: '
      end
    end
    
  end
end

class Codemaker < Player

  def create_random_code
    code = []
    $SLOTS.times { code << $COLORS[rand(0...$COLOR_AMOUNT)] }
    return code
  end

end

class Decoder < Player
  

  
end


game = Game.new(12,4,6)

=begin
game = Game.new(12,4,6)


game_over = false

if game.player.class.to_s == "Decoder"
  game.set_code_pattern(game.opponent.create_random_code)
  puts ""
  game.display(game.code_pattern,0,0)

  10.times do
    print "\n"
    game.add_guess(game.opponent.create_random_code)
    exact_matches = game.number_of_exact_matches(game.all_guesses.last)
    #game.indexes_of_exact_matches(game.all_guesses.last)
    color_matches = game.number_of_color_matches(game.all_guesses.last)
    game.display(game.all_guesses.last, exact_matches, color_matches)
  end



  until game_over
    game.add_guess(game.player.enter_code_row)
    exact_matches = game.number_of_exact_matches(game.all_guesses.last)
    #game.indexes_of_exact_matches(game.all_guesses.last)
    color_matches = game.number_of_color_matches(game.all_guesses.last)
    game.display(game.all_guesses.last, exact_matches, color_matches)
  
    #game.player.enter_code_row
  game_over = false
  
  end

end

=end
