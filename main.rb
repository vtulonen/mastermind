require 'byebug'
require './Game.rb'

class Player
  def initialize(name)
    @name = name
  end
    
  def name
    @name
  end

  def enter_code_row(code_or_guess)
    
    print "Your #{code_or_guess}: "
    while true
    input = gets.chomp.upcase!
      if input.match(/[GOPBYR]{4}/i)
        return input.split('')
      else 
        print '   #  Try again: '
      end
    end
    
  end

  def create_random_code
    code = []
    $SLOTS.times { code << $COLORS[rand(0...$COLOR_AMOUNT)] }
    return code
  end

end

class Codemaker < Player
  #computer guess methods

  def cpu_guess(last_guess_matches, all_guesses)
    latest = all_guesses.clone.last
    new_guess = []
    exact = last_guess_matches[:exact].clone
    color = last_guess_matches[:color].clone
    
    
    if last_guess_matches.values.all?(0)
      ##byebug
      return create_random_code 

    else
      byebug
      if $exacts_by_guess.last > exact && all_guesses.length > 2
        latest = all_guesses.clone[all_guesses.length-2]
        #exact = latest-matches ----.....
      end
      $exacts_by_guess << exact
      exact.times do
        new_guess << latest[rand(0...$SLOTS)]
      end
      color.times do
        add = ""
        while true
          add = latest[rand(0...$SLOTS)] 
          break if add != new_guess.any?
        end
        new_guess << add
      end

      (4 - exact - color).times do
        new_guess << $COLORS[rand(0...$COLOR_AMOUNT)] 
      end
    end
    byebug if new_guess.nil?
    return new_guess
  end

  def guess_with_exact_matches(exact_matches)
    
  end
end

class Decoder < Player
  
end

game = Game.new(12,4,6)

