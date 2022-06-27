class ComputerBreaker
  require_relative 'code'

  attr_reader :set, :best_guess

  def initialize
    @best_guess = Code.new(1122)
    @set = []
    for i in 1..6
      for j in 1..6
        for k in 1..6
          for l in 1..6
            @set.push(Code.new(i * 1000 + j * 100 + k * 10 + l))
          end
        end
      end
    end
  end

  def play_guess
    sleep(1)
    best_guess
  end

  def improve_next_guess(response)
    filter_non_matches(response)
    @best_guess = @set.sample
  end

  private

  def filter_non_matches(response)
    @set = @set.select { |value| value.compare(best_guess).sort == response.sort }
  end
end
