require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
    other_class = params[:class_name] || name.to_s.singularize.capitalize
  end

  def other_table
    other_table_name = other_class.constantize.table_name
  end
end

class BelongsToAssocParams < AssocParams
  def initialize(name, params)

  end

  def type
  end
end

class HasManyAssocParams < AssocParams
  def initialize(name, params, self_class)
  end

  def type
  end
end

module Associatable
  def assoc_params

  end

  def belongs_to(name, params = {})

    define_method(name) {
      other_class = params[:class_name] || name.to_s.singularize.capitalize
      foreign_key = params[:foreign_key] || "#{name}_id"
      primary_key = params[:primary_key] || "id"
      other_table_name = other_class.constantize.table_name

      query = <<-SQL
      SELECT *
      FROM #{other_table_name}
      WHERE  #{primary_key} = #{self.id}
      SQL

      other_class.constantize.parse_all(DBConnection.execute(query))
      }
  end

  def has_many(name, params = {})
    define_method(name) {
      other_class = params[:class_name] || "#{name}".singularize.camelize
      foreign_key = params[:foreign_key] || "#{table_name.singularize}_id"
      primary_key = params[:primary_key] || "id"
      other_table_name = other_class.constantize.table_name

      query = <<-SQL
      SELECT *
      FROM #{other_table_name}
      WHERE #{self.id} = #{primary_key}
      SQL
      other_class.constantize.parse_all(DBConnection.execute(query))
      }
  end

  def has_one_through(name, assoc1, assoc2)
  end
end
