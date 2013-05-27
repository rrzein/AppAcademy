class Fixnum
  def in_words
    return "zero" if self == 0
    ones = {
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine"
    }

    teens = {
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen"
    }

    tens = {
      2 => "twenty",
      3 => "thirty",
      4 => "forty",
      5 => "fifty",
      6 => "sixty",
      7 => "seventy",
      8 => "eighty",
      9 => "ninety"
    }

    words_array = []

    numbers_left = self
    set_no = 1

    while numbers_left > 0

    set = numbers_left % 1000
    numbers_left = numbers_left / 10**3

      if set != 0
        case set_no
        when 2
          words_array << "thousand"
        when 3
          words_array << "million"
        when 4
          words_array << "billion"
        when 5
          words_array << "trillion"
        end
      end

      if set >= 100
      #process the first two digits
        tens_ones = set % 100
        if tens_ones < 10
          words_array << ones[tens_ones]
        elsif tens_ones >= 10 && tens_ones < 20
          words_array << teens[tens_ones]
        else
          tens_digit = (tens_ones / 10) % 10
          one_digit = tens_ones % 10
          words_array << ones[one_digit]
          words_array << tens[tens_digit]
        end
        hundreds_digit = (set / 10**2) % 10
        words_array << ones[hundreds_digit] + " hundred"
      else set < 100
        tens_ones = set % 100
        if tens_ones < 10
          words_array << ones[tens_ones]
        elsif tens_ones >= 10 && tens_ones < 20
          words_array << teens[tens_ones]
        else
          tens_digit = (tens_ones / 10) % 10
          one_digit = tens_ones % 10
          words_array << ones[one_digit]
          words_array << tens[tens_digit]
        end
      end

      set_no += 1
      end

    #if smaller than 100
    words_array.reverse.join(" ").gsub(/\s+\s+/, " ").strip
  end

end