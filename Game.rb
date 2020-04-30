require 'byebug'
class Game
   
  attr_accessor :code_pattern, :opponent, :player

  @@all_guesses = [" "]
  
  @opponent
  @player
  @code_pattern

  def initialize(max_guesses,slots,color_amount) #rules = constant
    $MAX_GUESSES = max_guesses
    $SLOTS = slots 
    $COLOR_AMOUNT = color_amount
    $COLORS = ["G","O","P","B","Y","R"]
    setup
  end

  def setup
    
    display_rules
    @player = Codemaker.new("Player")#choose_role
    @opponent = Decoder.new("Computer")#choose_opponent
    
    #system "clear" || "cls"
=begin
    print "\n"
    display_possible_colors($COLORS)
    print "           #{add_color(15,"GUESS           MATCH    COLOR MATCH")}\n"
    self.display(["?", "?", "?", "?"],0,0)
    #play
=end
  end

  def add_guess(guess)
    @@all_guesses << guess
  end

  def all_guesses
    @@all_guesses
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

  def add_guess(guess)
    @@all_guesses << guess
  end


  def matches(guess)
    temp = code_pattern.clone
    matches = {exact: 0, color: 0}
    checked = []
    
    guess.each_with_index do |e,index|
      if e == temp[index]
        matches[:exact] += 1 
        temp[index] = 'X'
      end
    end
    
    guess.each_with_index do |e,index|
      next if temp[index] == "X" || checked.any?(e)
      t_count = temp.count(e)
      g_count = guess.count(e)
      count = t_count if t_count == g_count
      count ||= t_count - g_count
      count = 0 if count.negative?
      matches[:color] += count
      checked << e
    end

    return matches
  end

  
  def who_won
    winner =""
    matches = matches(all_guesses.last)
    if  matches[:exact] == 4
      winner = Decoder.name.to_s 
     
    elsif all_guesses.length == 12
    winner = Codemaker.name.to_s 
    end
    (winner == player.class.to_s) ? (return player.name) : (return opponent.name)
  end
  


  # Main game logic

  def play
    game_over = false
    
    if player.class.to_s == "Decoder"
      set_code_pattern(opponent.create_random_code)
      display(code_pattern,0,0) # to check TODO: remove for ready
  
      until game_over
        add_guess(player.enter_code_row("guess"))
        matches = matches(all_guesses.last)
        display(all_guesses.last, matches[:exact], matches[:color])
        if matches[:exact] == $SLOTS
          game_over = true 
          print "\n   # Code cracked! "
        elsif
         all_guesses.length == $MAX_GUESSES
         game_over = true 
         print "\n   # 12 tries used... "
        end
      end
    end
  
    if player.class.to_s == "Codemaker"
      set_code_pattern(player.enter_code_row("code"))
      display(code_pattern,0,0) # to check TODO: remove for ready
      last_guess_matches = matches(["","","",""])
      $exacts_by_guess = [0]
      until game_over
        add_guess(opponent.cpu_guess(last_guess_matches,all_guesses))
        
        matches = matches(all_guesses.last)
        
        last_guess_matches = matches.clone
        #byebug
        display(all_guesses.last, matches[:exact], matches[:color])
        if matches[:exact] == $SLOTS
          game_over = true 
          print "\n   # Code cracked! "
        elsif
         all_guesses.length == $MAX_GUESSES
         game_over = true 
         print "\n   # 12 tries used... "
        end
      end
    end
  
    print "#{who_won} wins!\n\n"
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
    
      print "\n   #--------------------------------------------#\n   |  |"
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
