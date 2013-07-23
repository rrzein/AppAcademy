class MassObject
  def self.set_attrs(*attributes)
    @attributes = attributes

    attributes.each do |attribute|
      attr_accessor attribute
    end
  end

  def self.attributes
    @attributes
  end

  def self.parse_all(results)
    all_rows = []
    results.each do |row|
      all_rows << self.new(self.hashify_row(row))
    end
    all_rows
  end

  def self.hashify_row(row)
    new_row = Hash.new
    row.each do |key, value|
      new_row[key.to_sym] = value
    end
    new_row
  end

  def initialize(params = {})

    params.each do |attr_name, value|
      if self.class.attributes.include?(attr_name.to_sym)
        self.send("#{attr_name}=", value)
      else
        raise "mass assignment to unregistered attribute #{attr_name}"
      end
    end
  end
end
