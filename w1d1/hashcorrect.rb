def hash_correct(wrong_hash)
  correct_hash = Hash.new
  wrong_hash.each do |key, val|
    correct_hash[key.to_s.next.to_sym] = val
  end
  correct_hash
end

wrong_hash = { :a => "banana", :b => "cabbage", :c => "dental_floss", :d => "eel_sushi" }

p hash_correct(wrong_hash)