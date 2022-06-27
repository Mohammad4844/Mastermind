class Game
  require_relative 'output'
  require_relative 'computer_breaker'
  require_relative 'player'

  attr_reader :master_code, :player

  def initialize; end

  def play
    Output.print_instructions
    get_player_with_role
    make_master_code
    break_master_code
  end

  private

  def get_player_with_role
    begin
      input = gets.chomp.to_i
      raise 'Input Error' unless input == 1 || input == 2
    rescue
      print 'Invalid entry. Please try again: '
      retry
    else
      @player = Player.new(input)
    end
  end

  def make_master_code
    if @player.role == 'CODE-MAKER'
      print 'Enter a valid code for the computer to break: '
      begin
        code = valid_digits?(gets.chomp)
      rescue
        print 'Invalid code. Please try again: '
        retry
      else
        @master_code = Code.new(code)
      end
    else
      @master_code = generate_random_code
    end
  end

  def break_master_code
    if @player.role == 'CODE-BREAKER'
      player_breaks_code
    else
      computer_breaks_code
    end
  end

  def player_breaks_code
    for turn in 1..11
      guess_code = Code.new(get_valid_guess)
      comparison = @master_code.compare(guess_code)
      return end_game_with_win if comparison.all? { |value| value == "MATCH" } # return causes game to end on win
      Output.print_code_with_clue(guess_code, comparison, 12 - turn)
    end
    end_game_with_loss
  end

  def computer_breaks_code
    computer = ComputerBreaker.new
    for turn in 1..11
      guess_code = computer.play_guess
      comparison = @master_code.compare(guess_code)
      computer.improve_next_guess(comparison)
      return end_game_with_win if comparison.all? { |value| value == "MATCH" } # return causes game to end on win
      Output.print_code_with_clue(guess_code, comparison, 12 - turn)
    end
    end_game_with_loss
  end

  def end_game_with_win
    print "\n"
    Output.print_code(@master_code)
    print "\n\e[34m#{"\nThe code was broken successfully!\n\n"}\e[0m"
  end

  def end_game_with_loss
    print "\e[31m#{"There are no more turns left! The code was:\n\n"}\e[0m"
    Output.print_code(@master_code)
    print "\n\n"
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