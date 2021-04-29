require_relative '../app/game'
#require 'pry'

class Application
  def perform
    # méthode qui initialise le jeu puis fait tourner le jeu tant que la partie n'est pas terminée.
    game = Game.new
    board = Board.new
    game.turn(board)
  end
end

#binding.pry
