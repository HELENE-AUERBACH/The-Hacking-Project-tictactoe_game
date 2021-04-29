#require 'pry'

class Player

  attr_reader :name # indique le nom du joueur (String)
  attr_reader :symbol # indique la valeur du joueur (String : "X" ou "O")

  def initialize(nom, symbol)
    @name = nom
    @symbol = symbol
  end
end

#binding.pry
