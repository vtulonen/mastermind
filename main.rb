require 'byebug'

class Game

end




class Pin
  attr_accessor :data
  def initialize(color,letter)
    @data = { color: color, letter: letter }
  end


end

class Board

  def initialize(max_guesses,slots,color_amount)
    @max_guesses = max_guesses
    @slots = slots 
    @color_amount = color_amount
    @code_pins = [ {color: "red", letter: "R"}, {color: "white", letter: "W"}]
  end

  def display
    puts "Hi! " + `tput setaf 1` + "This is red!" + `tput sgr0`
    puts "Hi! " + `tput setaf 2` + "This is green!" + `tput sgr0`
    puts "Hi! " + `tput setaf 3` + "This is orange!" + `tput sgr0`
    
    puts "Hi! " + `tput setaf 5` + "This is purple!" + `tput sgr0`
    puts "Hi! " + `tput setaf 6` + "This is (light)blue!" + `tput sgr0`
    
  end

  def code_pins
    @code_pins
  end
  
  #@code_pins = [{color: "red", letter: "R"}]
  #@code_pins << {color: "red", letter: "R"}

  private
    @code_pattern = {}
    @guess_rows = []
    
    @key_pins




end








class Player
  def initialize(role)
    @role = role
  end

  def role
    @role
end
    
end

class Human < Player
    def hi
        puts "hi"
    end
end

class Computer < Player

end

board = Board.new(12,4,4)
p board.code_pins[0][:color]