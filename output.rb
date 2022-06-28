# Module containing useful methods to output instructions, codes with their respective colors, and colored clue keys to
# the standard output
module Output
  require_relative 'colorize'

  def self.print_instructions
    temp = Code.new(4126)
    puts <<~INSTRUCTIONS

      \e[4m#{"\e[1m#{'How to play:'}\e[22m"}\e[24m

      Mastermind is a 1-player game against a computer, where you can be either the code maker or the code breaker. There are 6 different color/number combinations:

    INSTRUCTIONS
    print_code(Code.new(123456))
    puts <<~INSTRUCTIONS
      \n
      The code maker will choose 4 of them to make a master code, for example:

    INSTRUCTIONS
    print_code(temp)
    puts <<~INSTRUCTIONS
      \n
      \e[4m#{"\e[1m#{'Clue:'}\e[22m"}\e[24m

      After each guess, you will be given a response with up to 4 clues to help you crack the code.

      \e[31m#{"\u2666"}\e[0m A red key means there is a correct number in the correct position
      \e[37m#{"\u2666"}\e[0m An white key means there is a correct number in the wrong position

      \e[4m#{"\e[1m#{'Example:'}\e[22m"}\e[24m

      Considering the master code above, a guess of '4631' would give the following response:
    INSTRUCTIONS
    print_code_with_clue(temp, temp.compare(Code.new(4631)))
    puts <<~INSTRUCTIONS
      \e[4m#{"\e[1m#{'Time to play!'}\e[22m"}\e[24m

      Duplicate values in the code are allowed. To win, you have to guess the code \e[31m#{'within 12 turns'}\e[0m. 
        
      Enter 1 if you want to be \e[34m#{'Code Maker'}\e[0m
      Enter 2 if you want to be \e[34m#{'Code Breaker'}\e[0m
    INSTRUCTIONS
  end

  def self.print_code_with_clue(code, array_of_comparisons, turns_left = 0)
    print "\n"
    print_code(code)
    print_clues(array_of_comparisons) 
    print "\e[32m#{" Turns left: #{turns_left}"}\e[0m" unless turns_left == 0
    print "\n\n"
  end

  def self.print_code(code)
    code.digits.each { |digit| print Colorize.bg_color(digit) }
  end

  def self.print_clues(array_of_comparisons)
    print ' Clues: '
    array_of_comparisons.each { |comparison| print "\e[31m#{"\u2666"}\e[0m " if comparison == 'MATCH' }
    array_of_comparisons.each { |comparison| print "\e[37m#{"\u2666"}\e[0m " if comparison == 'LOCATION' }
  end
end
