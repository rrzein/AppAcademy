def num_to_s(num, base)
  hash = {
    0 => "0",
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F"
  }

  output = ""

  i = 0

  until (base**i > num)
    digit = (num / base**i) % base
    output << hash[digit]

    i += 1
  end

  output.reverse
end

puts num_to_s(47, 16)