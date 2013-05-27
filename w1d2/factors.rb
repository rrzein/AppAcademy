def factors(n)
  (1..n).select { |factor| n % factor == 0 }
end

def all_factors(n)
  all_factors = []
  n.times { |number| all_factors << factors(number) }
  all_factors
end