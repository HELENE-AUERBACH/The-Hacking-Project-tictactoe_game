require_relative './player'
#require 'pry'

class Game
  attr_accessor :current_player # il s'agit du joueur qui a la main (Player)
  attr_accessor :status # indique l'état du jeu (String : "on going", "draw" (match nul) ou le prénom du vainqueur)
  attr_reader :players # Array des 2 joueurs

  def initialize
    @status = "on going"
    @players = []
    2.times do |index|
      if index == 0 
        symbol = "X"
      else
        symbol = "O"
      end
      @players << get_new_player(symbol, index)
    end
    @current_player = @players[0]
  end
  
  def turn
    #TO DO : méthode faisant appelle aux méthodes des autres classes (notamment à l'instance de Board). Elle affiche le plateau, demande au joueur ce qu'il joue, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie.
  end

  def new_round
    # TO DO : relance une partie en initialisant un nouveau board mais en gardant les mêmes joueurs.
  end

  def game_end
    # TO DO : permet l'affichage de fin de partie quand un vainqueur est détecté ou si il y a match nul
  end    
  
  private

  def get_new_player(symbol, index)
    print "Quel est le prénom du #{index == 0 ? "premier" : "second"} joueur ?\n> "
    first_name = gets.chomp
    player = Player.new(first_name, symbol)
    return player
  end
end

#binding.pry
