require_relative './board_case'
#require 'pry'

class Board
  attr_accessor :cells # un Array qui contient les BoardCases.
  attr_accessor :count_turn # un Integer pour compter le nombre de coups joués

  def initialize
    @cells = []
    @count_turn = 0
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

  def play_turn(current_player)
    case_index = get_board_case_index(current_player) #1) demande au bon joueur ce qu'il souhaite faire
    @cells[case_index].value = current_player.symbol #2) change la BoardCase jouée en fonction de la valeur du joueur (X ou O)
    @count_turn += 1
    return nil
  end

  def victory?
    # vérifie le plateau et indique s'il y a un vainqueur ou match nul
    result = nil
    spaces_total = 0
    x_total = 0
    o_total = 0
    9.times do |case_index|
      case @cells[case_index].value
      when "X"
        x_total += 1
      when "O"
        o_total += 1
      else
        spaces_total += 1
      end
    end
    if spaces_total < 9 && (x_total >= 3 || o_total >= 3)
      if !victory_in_row.nil?
        result = victory_in_row
      elsif !victory_in_column.nil?
        result = victory_in_column
      elsif !victory_in_diagonal.nil?
        result = victory_in_diagonal
      elsif spaces_total == 0
        result = "draw"
      end
    end
    return result
  end

  private

  def get_board_case_index(current_player)
    case_index = -1
    while case_index == -1 || @cells[case_index].value != " "
      if case_index != -1 && @cells[case_index].value != " "
        puts "Malheureusement, cette case est déjà occupée par un pion \"#{@cells[case_index].value}\"."
      end
      print "\nJoueur \"#{current_player.name}\", sur quelle case souhaites-tu poser ton pion ?\n> "
      answer = gets.chomp
      while !check_answer?(answer)
        puts "Veuillez saisir un identifiant de case avec la lettre majuscule de la colonne (A, B ou C) suivie du numéro de ligne (1, 2 ou 3) (par exemple : A1)."
        print "> "
        answer = gets.chomp 
      end
      letter = answer[0]
      row = answer[1]
      case_index = transform_row(row) + transform_letter(letter)
    end
    puts "Tu as bien placé ton pion \"#{current_player.symbol}\" sur la case \"#{answer.strip}\".\n"
    return case_index
  end

  def transform_letter(letter)
    return (letter == "A") ? 0 : ((letter == "B") ? 1 : 2)
  end

  def transform_row(row)
    row_to_i = row.to_i
    return (row_to_i == 1) ? 0 : ((row_to_i == 2) ? 3 : 6)
  end

  def check_answer?(answer)
    result = false
    if !answer.nil? && answer.instance_of?(String) && !answer.strip.empty? && answer.strip.length == 2
      letter = answer[0]
      row = answer[1]
      if (('A'..'C').cover? letter) && (('1'..'3').cover? row) 
        result = true
      end
    end
    return result
  end

  def victory_in_row
    result = nil
    row_number = 0
    3.times do
      value = @cells[0 + row_number].value
      if value != " " # la ligne ne peut pas être gagnante sinon
        total = 1
        2.times do |case_index|
          if @cells[case_index + 1 + row_number].value == value
            total += 1
          else
            break # la ligne ne peut pas être gagnante 
          end
        end
        if total == 3
          if value == "X"
            result = "0"
          else
            result = "1"
          end
          break # on a une ligne de 3 pions de même valeur gagnante
        end
      end
      row_number += 3
    end
    return result
  end

  def victory_in_column
    result = nil
    3.times do |column_number|
      value = @cells[column_number].value
      if value != " " # la colonne ne peut pas être gagnante sinon
        total = 1
        case_index = 3 + column_number
        2.times do
          if @cells[case_index].value == value
            total += 1
          else
            break # la colonne ne peut pas être gagnante 
          end
          case_index += 3
        end
        if total == 3
          if value == "X"
            result = "0"
          else
            result = "1"
          end
          break # on a une colonne de 3 pions de même valeur gagnante
        end
      end
    end
    return result
  end

  def victory_in_diagonal
    result = nil
    case_index = 0
    value = @cells[case_index].value
    if value != " " # la diagonale ne peut pas être gagnante sinon
      total = 1
      2.times do
        case_index += 4
        if @cells[case_index].value == value
          total += 1
        else
          break # la diagonale ne peut pas être gagnante 
        end
      end
    end
    if total != 3
      case_index = 2
      value = @cells[case_index].value
      if value != " " # la diagonale ne peut pas être gagnante sinon
        total = 1
        2.times do
          case_index += 2
          if @cells[case_index].value == value
            total += 1
          else
            break # la diagonale ne peut pas être gagnante 
          end
        end
      end
    end
    if total == 3 # on a une diagonale de 3 pions de même valeur gagnante
      if value == "X"
        result = "0"
      else
        result = "1"
      end
    end
    return result
  end
end

#binding.pry
