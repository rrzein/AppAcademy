class Player

  def get_move
    puts "Please enter a move in in the form of coordinates. For example: e2-e4."
    input = gets.chomp
    parse(input)
  end

  def parse(input)
    puts "input"
    origin, destination = input.split("-")
    puts "Origin: #{origin}, Destination: #{destination}"
    origin_file, origin_rank = origin.split(//)
    puts "Origin_file : #{origin_file}, Origin_rank : #{origin_rank}"
    destination_file, destination_rank = destination.split(//)
    puts "Destination_file : #{destination_file}, Destination_rank : #{destination_rank}. "

    origin_row = rank_to_row(origin_rank)
    destination_row = rank_to_row(destination_rank)
    puts "Origin row: #{origin_row}, Destination_row: #{destination_row}."

    origin_column = file_to_column(origin_file)
    destination_column = file_to_column(destination_file)
    puts "Origin_column = #{origin_column}, Dest_col : #{destination_column}"

    [[origin_row, origin_column], [destination_row, destination_column]]
  end

  def rank_to_row(rank)
    conversion_hash = {
      8 => 0,
      7 => 1,
      6 => 2,
      5 => 3,
      4 => 4,
      3 => 5,
      2 => 6,
      1 => 7
    }

    conversion_hash[rank.to_i]
  end

  def file_to_column(file)
    conversion_hash = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7
    }

    conversion_hash[file]
  end


  # def row_to_rank(row)
  #
  # end

end