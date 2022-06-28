class Code
  attr_reader :digits

  def initialize(n) 
    @digits = int_to_array(n)
  end

  # Method that compares another other Code object with the current one. Returns an array of strings containing 
  # information about the comparison, where each index represents the comparison of the respective digit. 
  # MATCH means there was an exact match, LOCATION means there is a coorect digit present but in a diffrent lovcation, 
  # and INCORRECT means nothing mathces.
  def compare(code)
    results = Array.new(4, 'INCORRECT') # MATCH, LOCATION, INCORRECT
    unmatched_numbers = []
    code.digits.each_with_index do |digit, i| 
      if digit == self.digits[i]
        results[i] = 'MATCH'
      else
        unmatched_numbers.push(self.digits[i])
      end
    end
    code.digits.each_with_index do |digit, i| 
      results[i] = 'LOCATION' if results[i] != 'MATCH' && unmatched_numbers.include?(digit) 
    end
    results
  end

  private

  def int_to_array(n)
    n.to_s.split('').map { |digit| digit.to_i }
  end
end

