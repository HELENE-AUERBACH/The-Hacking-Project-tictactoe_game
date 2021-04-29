require_relative './board_case'
#require 'pry'

class Board
  attr_accessor :cells # un Array qui contient les BoardCases.
  attr_accessor :count_turn # un Integer pour compter le nombre de coups joués

  def initialize
    @cells = []
    #Quand la classe s'initialise, elle doit créer 9 instances de la classe BoardCase
    letter = nil # indique la position verticale de la case sur le plateau (String : "A", "B" ou "C")
    row = 1 # indique la position horizontale (Integer : 1, 2 ou 3)
    9.times do |index|
      case index % 3
      when 0
        letter = "A"
      when 1
        letter = "B"
      when 2
        letter = "C"
      end

      board_case = BoardCase.new("#{letter}#{row.to_s}", " ")
      @cells << board_case #Ces instances sont rangées dans la variable d'instance "cells" de la classe

      if letter == "C"
        row += 1 # préparation du numéro de ligne suivante
      end
    end
  end

  def play_turn
    #TO DO : une méthode qui :
    #1) demande au bon joueur ce qu'il souhaite faire
    #2) change la BoardCase jouée en fonction de la valeur du joueur (X ou O)
  end

  def victory?
    #TO DO : une méthode qui vérifie le plateau et indique s'il y a un vainqueur ou match nul
  end

  private

  def menu(player)
  end
end

#binding.pry
