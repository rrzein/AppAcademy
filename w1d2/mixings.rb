#split up the ingredients
#shuffle them arround
#put them back together
#give it back to the user

original_ingredients = [
["rum", "coke"],
["gin", "tonic"],
["scotch", "soda"]]

def remix(ingredients)
  liquors = []
  mixers = []
  mixed_up = []

  ingredients.each do |(liquor, mixer)|
    liquors << liquor
    mixers << mixer
  end

  until mixed_up.count == ingredients.count
    pairing = [liquors.shuffle.last, mixers.shuffle.last]
    mixed_up << pairing unless ingredients.include?(pairing)
  end

  mixed_up
end

p remix(original_ingredients)