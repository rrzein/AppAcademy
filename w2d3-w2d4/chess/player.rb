# encoding: utf-8

class Player

  def initialize(color)
    @color = color.to_s.capitalize
  end

  def get_move
    puts "#{@color}, please enter a move in coordinates. For example: e2-e4."
    input = gets.chomp
    parse(input)
  end

  def parse(input)
    origin, destination = input.split("-")
    origin_file, origin_rank = origin.split(//)
    destination_file, destination_rank = destination.split(//)

    origin_row = rank_to_row(origin_rank)
    destination_row = rank_to_row(destination_rank)

    origin_column = file_to_column(origin_file)
    destination_column = file_to_column(destination_file)

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