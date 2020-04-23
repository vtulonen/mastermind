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
    @colors = ["G","O","P","B","Y","R"]

    @code_pins = [ 
      {color: "red", letter: "R", function: "correct_place"}, 
      {color: "white", letter: "W", function: "correct_color"}]
  end

  def create_random_code
   
    code = []
    @slots.times { code << @colors[rand(0...@color_amount)] }
    return code
  end

  def set_code_pattern(code_pattern)
    @code_pattern = code_pattern
  end

  def code_pattern
    @code_pattern
  end


  def display
    puts "Hi! " + `tput setaf 196` + "This is red!" + `tput sgr0`
    puts "Hi! " + `tput setaf 2` + "This is green!" + `tput sgr0`
    puts "Hi! " + `tput setaf 202` + "This is orange!" + `tput sgr0`
    puts "Hi! " + `tput setaf 5` + "This is purple!" + `tput sgr0`
    puts "Hi! " + `tput setaf 14` + "This is (light)blue!" + `tput sgr0`
    puts "Hi! " + `tput setaf 11` + "This is yellow!" + `tput sgr0`

    puts "Hi! " + `tput setaf 15` + "This is superWHITE!" + `tput sgr0`
  end

  


  @code_pattern = []
  private
    
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

def colorize(char)
  case char
  when "R"
    return `tput setaf 196` + "R" + `tput sgr0`
  when "G"
    return `tput setaf 10` + "G" + `tput sgr0`
  when "O"
    return `tput setaf 202` + "O" + `tput sgr0`
  when "B"
    return `tput setaf 14` + "B" + `tput sgr0`
  when "P"
    return `tput setaf 5` + "P" + `tput sgr0`
  when "Y"
    return `tput setaf 11` + "Y" + `tput sgr0`
  else return char
  end
  
end

def add_color(setafnum, var)
  var = var.to_s
  return `tput setaf #{setafnum}` + var + `tput sgr0`
end

board = Board.new(12,4,6)

a = board.set_code_pattern(board.create_random_code)
#board.code_pattern.each {|i| print "#{colorize(i)} "}
#board.display

def display(code, correct_both, correct_color)
  
  print "|" 
  code.each {|i| print " #{colorize(i)} |"}
  print "    [#{add_color(196,correct_both)}]        [#{add_color(15,correct_color)}]"
  print "\n----------------------------------------\n"
  
end
print "      GUESS         MATCH    COLOR MATCH\n"
print "----------------------------------------\n"
2.times {display(a,2,2)}