require 'byebug'
class Game
   
  @@all_guesses = []

  def initialize(max_guesses,slots,color_amount) #rules = constant
    $MAX_GUESSES = max_guesses
    $SLOTS = slots 
    $COLOR_AMOUNT = color_amount
    $COLORS = ["G","O","P","B","Y","R"]
    setup
  end

  def setup
    
    display_rules
    @player = choose_role
    @opponent = choose_opponent
    system "clear" || "cls"
    print "\n"
    display_possible_colors($COLORS)
    print "           #{add_color(15,"GUESS           MATCH    COLOR MATCH")}\n"
    self.display(["?", "?", "?", "?"],0,0)
    play
  end

  def player
    @player
  end

  def opponent
    @opponent
  end

  def display_rules
    print "              Welcome to Master Mind!\n\n"
    print "   #  As a decoder your job is to guess\n"
    print "   #  a code made of #{$COLOR_AMOUNT} colored letters.\n"
    print "   #  When you get a correct color in your\n"
    print "   #  guess, the computer marks the amount\n"
    print "   #  with a white number on the board. If\n"
    print "   #  you get a color on the correct place\n"
    print "   #  it'll be indicated with a red number.\n"
    print "   #  Crack the code in 12 turn or less to\n"
    print "   #  win. If you wish to be the codemaker\n"
    print "   #  the computer will try to guess it.\n"
    print "   #  When entering a color, use the first\n"
    print "   #  letter of the color like shown below.\n\n"
    print "   #             Good luck!\n\n"
    display_possible_colors($COLORS)
  end

  def choose_role
    print "   #  Choose your role: Decoder / Codemaker (d/c): "
    
    
    while true
      input = gets.chomp.upcase!
      if input == "D"
        return Decoder.new("Player")
      elsif input == "C" 
        return Codemaker.new("Player")
      else print '   #  Enter "D" or "C": '
      end
    end
  end

  def choose_opponent
    if defined?(Decoder)
      return Codemaker.new("Computer")
    else return Decoder.new("Computer")
    end
  end
  
  def set_code_pattern(code_pattern)
    @code_pattern = code_pattern
  end

  def code_pattern
    @code_pattern
  end

  def add_guess(guess)
    @@all_guesses << guess
  end

  def all_guesses
    @@all_guesses
  end

  def number_of_exact_matches(code)
    matches = 0
    code.each_with_index do |e,index|
      matches += 1 if e == code_pattern[index]
    end
    return matches
  end

  def exacts_to_X(code)
    exacts_marked = code.each_with_index.map do |e,index|
       if e == code_pattern[index]
        e = "X" 
       else 
        e = e
       end
    end
    return exacts_marked
  end

  def number_of_color_matches(code)
    exacts = exacts_to_X(code)
    matches = 0
    
    exacts.each_with_index do |e, index|
      #byebug
      if e == "X"
        next
      end

      if  exacts.any?(e)
        matches += 1
      end
    end
    return matches
  end

  







  

  
  #Display methods

  
  def add_color(setafnum, var)
    var = var.to_s
    return `tput setaf #{setafnum}` + var + `tput sgr0`
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

  def display(code_pattern, exact_match, color_match)
    
      print "   #--------------------------------------------#\n   |  |"
      code_pattern.each {|i| print " #{colorize(i)} |"}
      print "     [#{add_color(196,exact_match)}]         [#{add_color(15,color_match)}]     |"
      print "\n   #--------------------------------------------# -> "
      
    end

  def display_possible_colors(colors)
    print "   #--------------------------------------------#\n"
    print "   #  COLORS     "
    print " |"
    colors.each {|i| print " #{colorize(i)} |"}
    print "     #\n   #--------------------------------------------#\n\n"
  end
end

def play
  game_over = false


  if player.class.to_s == "Decoder"
    set_code_pattern(opponent.create_random_code)
    puts ""
    display(code_pattern,0,0)

    until game_over
      add_guess(player.enter_code_row)
      exact_matches = number_of_exact_matches(all_guesses.last)
      color_matches = number_of_color_matches(all_guesses.last)
      display(all_guesses.last, exact_matches, color_matches)
      game_over = true if exact_matches == 4
    end



  end

  if player.class.to_s == "Codemaker"

  end
end