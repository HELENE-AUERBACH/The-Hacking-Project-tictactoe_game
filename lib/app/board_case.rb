#require 'pry'

class BoardCase
  
  attr_reader :position # identifiant de case (String), par exemple : "A1"
  attr_accessor :value # sa valeur en String ("X", "O", ou " ")

  def initialize(position, value)
    @position = position
    @value = value
  end
end

#binding.pry
