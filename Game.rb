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
    print "          GUESS         MATCH    COLOR MATCH\n"
    print "   #-----------------------------------------#"
    self.display([" ", " ", " ", " "],0,0)
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
    print "   #  a coderow made of #{$COLOR_AMOUNT} colors.\n"
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
    print "Choose your role: Decoder / Codemaker (d/c): "
    input = gets.chomp.upcase!
    print "\n\n"
    if input == "D"
      return Decoder.new("Player")
    else return Codemaker.new("Player")
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

  def display(code_pattern, correct_both, correct_color)
  
      print "\n   |" 
      code_pattern.each {|i| print " #{colorize(i)} |"}
      print "     [#{add_color(196,correct_both)}]         [#{add_color(15,correct_color)}]     |"
      print "\n   #-----------------------------------------# -> "
      
    end

  def display_possible_colors(colors)
    print "   #      |"
    colors.each {|i| print " #{colorize(i)} |"}
    print "\n\n"
  end
end
