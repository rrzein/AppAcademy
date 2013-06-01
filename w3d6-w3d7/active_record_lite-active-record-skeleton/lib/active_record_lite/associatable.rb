require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
  end

  def other_table
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
    define_method(name) do
      other_class = params[:class_name].constantize || name.to_s.camelize.constantize
      other_table_name = other_class.table_name
      primary_key = params[:primary_key].to_s || "id"
      foreign_key = params[:foreign_key].to_s || "#{name}_id"

      query = <<-SQL
        SELECT *
        FROM #{other_table_name}
        WHERE #{other_table_name}.#{primary_key} = ?
      SQL

      other_class.parse_all(DBConnection.execute(query, send(foreign_key)))
    end
  end

  def has_many(name, params = {})
    define_method(name) do
      other_class = 
        if params[:class_name]
          params[:class_name].camelize.constantize
        else
          name.to_s.singularize.camelize.constantize
        end
      other_table_name = other_class.table_name
      primary_key = 
        if params[:primary_key]
          params[:primary_key].to_s
        else 
          "id"
        end
      foreign_key = params[:foreign_key].to_s || "#{self.class.to_s.underscore}_id"

      query = <<-SQL
        SELECT *
        FROM #{other_table_name}
        WHERE #{other_table_name}.#{foreign_key} = ?
      SQL

      other_class.parse_all(DBConnection.execute(query, send(primary_key)))
    end
  end

  def has_one_through(name, assoc1, assoc2)
  end
end
