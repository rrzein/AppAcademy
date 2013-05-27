def fourth_power(i)
  square(i) * square(i)   # wait, isn't square not defined yet?
end

def square(i)
  i * i
end

# Ah, but by the time we _call_ `fourth_power` and run the
# interior code, `square` will have been defined

p fourth_power(2)