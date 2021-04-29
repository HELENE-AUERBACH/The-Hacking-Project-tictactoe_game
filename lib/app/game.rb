require_relative './player'
require_relative './board'
require_relative '../views/show'

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
      puts "\nLe joueur \"#{@players[index].name}\" a pour symbole : #{symbol}.\n"
    end
    @current_player = @players[0]
  end
  
  def turn(board)
    Show.new.show_board(board) # affiche le plateau
    board.play_turn(@current_player) # demande au joueur ce qu'il joue
    if !(board.victory?).nil? # vérifie si un joueur a gagné
      game_end(board.victory?, board)
    else # passe au joueur suivant si la partie n'est pas finie
      @current_player = @players[(@players.find_index(@current_player) + 1) % 2]
      self.turn(board)
    end
  end

  def new_round
    # relance une partie en initialisant un nouveau board mais en gardant les mêmes joueurs.
    @status = "on going"
    board = Board.new
    self.turn(board)
  end

  def game_end(string_of_victory, board)
    # affichage de fin de partie quand un vainqueur est détecté ou s'il y a match nul
    if !string_of_victory.nil?
      Show.new.show_board(board) # affiche le plateau
      if string_of_victory == "draw"
        @status = string_of_victory
        result = "il y a match nul."
        puts "\nLa partie s'est terminée en #{board.count_turn} coups et #{result}"
      else
        if string_of_victory == "0"
          @status = @players[0].name
        else # string_of_victory == "1"
          @status = @players[1].name
        end
        result = "le vainqueur est le joueur \"#{@status}\"."
        puts "\nLa partie s'est terminée en #{board.count_turn} coups et #{result}"
      end
      print "\nDésirez-vous rejouer une nouvelle partie ? (N pour quitter le jeu)\n> "
      answer = gets.chomp
      if !answer.nil? && answer.instance_of?(String) && !answer.strip.empty? && !(answer.strip)[0].upcase.include?("N")
        puts "\nLa partie est relancée avec les mêmes joueurs."
        self.new_round
      else
        exit
      end
    end
  end

  private

  def get_new_player(symbol, index)
    print "\nQuel est le prénom du #{index == 0 ? "premier" : "second"} joueur ?\n> "
    first_name = gets.chomp
    player = Player.new(first_name, symbol)
    return player
  end
end

#binding.pry
