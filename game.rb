class Game
  require_relative 'output'

  attr_reader :master_code

  def initialize(master_code = generate_random_code)
    @master_code = master_code
  end

  def play
    Output.print_instructions
    gets # So game starts when user presses Enter
    for turn in 1..11
      guess_code = Code.new(get_valid_guess)
      comparison = master_code.compare(guess_code)
      return end_game_with_win if comparison.all? { |value| value == "MATCH" } # return causes game to end on win
      Output.print_code_with_clue(guess_code, comparison, 12 - turn)
    end
    end_game_with_loss
  end

  private

  def end_game_with_loss
    print "\e[31m#{"\nYou ran out of turns! The code was:\n\n"}\e[0m"
    Output.print_code(master_code)
    print "\n\n"
  end
  
  def end_game_with_win
    print "\n\n"
    Output.print_code(master_code)
    print "\e[34m#{"\nCongratulations, You broke the code!\n\n"}\e[0m"
  end

  def get_valid_guess
    print 'Enter a valid guess: '
    begin
      guess = valid_digits?(gets.chomp)
    rescue
      print 'Invalid guess. Please try again: '
      retry
    else
      return guess
    end
  end

  def valid_digits?(guess) # throws an error if digits aernt valid, returns the integer form 
    raise "Invalid Input" unless guess.length == 4
    guess.split('').each { |digit| raise "Invalid Input" unless digit.to_i.between?(1,6) }
    guess.to_i
  end

  def generate_random_code
    Code.new(rand(1..6) * 1000 + rand(1..6) * 100 + rand(1..6) * 10 + rand(1..6))
  end

end