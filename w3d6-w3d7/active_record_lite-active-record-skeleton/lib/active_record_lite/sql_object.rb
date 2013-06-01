require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'
require 'active_support/inflector'

class SQLObject < MassObject
  extend Searchable
  extend Associatable

  def self.set_table_name(table_name)
    @table_name = table_name.underscore
  end

  def self.table_name
    @table_name
  end

  def self.all
    query = <<-SQL
      SELECT *
      FROM #{table_name}
    SQL

    parse_all(DBConnection.execute(query))
  end

  def self.find(id)
    query = <<-SQL
      SELECT *
      FROM #{table_name}
      WHERE id = ?
    SQL

    self.new(DBConnection.execute(query, id).first)
  end

  def save
    self.id ? update : create
  end

  private

  def create
    attributes = self.class.attributes.join(", ")
    question_marks = (['?'] * self.class.attributes.count).join(", ")

    query = <<-SQL
      INSERT INTO #{self.class.table_name} (#{attributes})
      VALUES (#{question_marks})
    SQL

    DBConnection.execute(query, *attribute_values)
    self.id = DBConnection.last_insert_row_id.to_i
  end

  def update
    set_line = self.class.attributes.map do |attr_name| 
      "#{attr_name} = ?"
    end
    set_line = set_line.join(", ")

    query = <<-SQL
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE id = ?
    SQL

    DBConnection.execute(query, *attribute_values, self.id)
  end

  def attribute_values
    self.class.attributes.map { |attribute| self.send(attribute) }
  end
end
