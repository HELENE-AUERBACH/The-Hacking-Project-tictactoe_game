require_relative '../app/board'
require 'pry'

class Show

  def show_board(board)
    puts "Voici l'état actuel du plateau :"
    show_rows(board)
  end
  
  private

  def show_rows(board)
    show_columns_header
    9.times do |case_index|
      show_column(board, case_index)
      case case_index # Affichage d'un caractère de fin de ligne s'il s'agit de la dernière case de la ligne en question
      when 2, 5, 8
        puts "|"
      end
    end
  end

  def show_column(board, case_index)
    # Affichage d'une case du plateau précédée éventuellement de son numéro de ligne
    case case_index # Affichage du numéro de ligne s'il s'agit de la première case de la ligne en question
    when 0
      print "1 |"
    when 3
      print "2 |"
    when 6
      print "3 |"
    end
    print "| #{board.cells[case_index].value} |"
    #print "| #{board.cells[case_index].position} |"
  end

  def show_columns_header
    # Affichage de l'entête des colonnes du plateau
    puts "\n     A    B    C"
  end
end

binding.pry
