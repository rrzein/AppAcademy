def super_print(string, options = {})
  string
  defaults = {
    :times => 10,
    :upcase => true,
    :reverse => true
  }

  options = defaults.merge(options)

  super_string.upcase! if options[:upcase]
  super_string.reverse! if options[:reverse]
  options[:times].times { puts super_string }

  nil
end

super_print("hello there")