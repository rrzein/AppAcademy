#prompt for filename
#read a file
#shuffle the file
#saved it to a file #{input_name}-shuffled.txt

def shuffler
  puts "Please input a filename."
  filename = gets.chomp

  filecontents = File.readlines("#{filename}.txt")
  filecontents.shuffle!

    File.open("#{filename}-shuffled.txt", "w") do |line|
      until filecontents.empty? { line.puts filecontents.pop }
    end
end

shuffler