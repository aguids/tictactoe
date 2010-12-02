class TicTacToe
  
  LEFT_DIAGONAL  = [[0,0],[1,1],[2,2]]
  RIGHT_DIAGONAL = [[2,0],[1,1],[0,2]]
  
  PLAYERS = [:X, :O]
  
  def initialize
    @board = [[nil,nil,nil],
              [nil,nil,nil],
              [nil,nil,nil]]
  end
  
  def play
    PLAYERS.cycle do |current_player|
      print_board
      row, col = read_move

      begin
        cell_contents = @board.fetch(row).fetch(col)
      rescue IndexError
        puts "Out of bounds, try another position"
        redo
      end
  
      if cell_contents
        puts "Cell occupied, try another position"
        redo
      end

      @board[row][col] = current_player

      if win?(current_player, row, col)
        puts "#{current_player} wins!"
        exit
      end

      if draw?
        puts "It's a draw!"
        exit
      end
    end
  end
  
  def print_board
    puts @board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
  end
  
  def read_move
    print "\n>> "
    row, col = gets.split.map { |e| e.to_i }
    puts
    [row, col]
  end
  
  def draw?
    @board.flatten.compact.length == 9
  end
  
  def win?(current_player, row, col)
    lines = []

    [LEFT_DIAGONAL, RIGHT_DIAGONAL].each do |line|
      lines << line if line.include?([row,col])
    end

    lines << (0..2).map { |c1| [row, c1] }
    lines << (0..2).map { |r1| [r1, col] }

    win = lines.any? do |line|
      line.all? { |row,col| @board[row][col] == current_player }
    end
  end
end

TicTacToe.new.play