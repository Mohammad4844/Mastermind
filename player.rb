# Class Player representing the player of the mastermind game along with their current role
class Player
  attr_reader :role

  def initialize(num)
    @possible_roles = { 1 => 'CODE-MAKER', 2 => 'CODE-BREAKER' }
    @role = @possible_roles[num]
  end
end
