require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'
require 'active_support/inflector'

class SQLObject < MassObject
  extend Searchable
  extend Associatable

  def self.set_table_name(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name
  end

  def self.all
    query = <<-SQL
    SELECT *
    FROM #{table_name}
    SQL

    self.parse_all(DBConnection.execute(query))
  end

  def self.find(id)
    query = <<-SQL
    SELECT *
    FROM #{table_name}
    WHERE id = #{id}
    SQL

    self.new(self.hashify_row(DBConnection.execute(query).first))
  end

  private

  def create
    attribute_string = self.class.attributes.join(", ")
    question_marks = []
    self.class.attributes.size.times { question_marks << '?' }
    question_marks = question_marks.join(", ")

    query = <<-SQL
  INSERT INTO #{self.class.table_name} (#{attribute_string})
    VALUES (#{question_marks})
    SQL


    DBConnection.execute(query, *attribute_values)

    self.id = self.class.last_row_id
  end

  def update
    set_line = self.class.attributes.map do |attr_name|
      "#{attr_name} = ?"
    end.join(", ")


    query = <<-SQL
    UPDATE #{self.class.table_name}
    SET #{set_line}
    WHERE id = #{self.id}
    SQL

    DBConnection.execute(query, *attribute_values)
  end

  public

  def save
    self.id ? update : create
  end

  def attribute_values
    values = self.class.attributes.map do |attribute|
      self.send(attribute)
    end
    values
  end

  def self.last_row_id
    query = <<-SQL
    SELECT MAX(id)
    FROM #{table_name}
    SQL

    id = DBConnection.execute(query).first.values.first.to_i
  end
end
