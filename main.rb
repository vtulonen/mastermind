require 'byebug'
require './Game.rb'




class Player
  def initialize(name)
    @name = name
  end
    
  def name
    @name
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
  def enter_code_row
    print "Enter your guess:"
    input = gets.chomp.upcase!.split('')
    #validate(input) -> return 
  end

  
end


game = Game.new(12,4,6)


game_over = false
if game.player.class.to_s == "Decoder"
  until game_over
    game.set_code_pattern(game.opponent.create_random_code)
    game.add_guess(game.player.enter_code_row)
    game.display(game.all_guesses.last,2,2)
  
    #game.player.enter_code_row
  game_over = true
  
  end
end


