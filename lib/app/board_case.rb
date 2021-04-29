#require 'pry'

class BoardCase
  
  attr_accessor :position # identifiant de case (String)
  attr_accessor :value # sa valeur en string (X, O, ou vide)

  def initialize(position, value)
    @position = position
    @value = value
  end
end

#binding.pry
