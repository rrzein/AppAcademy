def da_shuffler(filename)
  File.open("#{filename}-shuffled", "w") do |f|
    File.readlines(filename).shuffle.each { |line| f.puts line.chomp }
  end
end

da_shuffler("burningmanstuff")