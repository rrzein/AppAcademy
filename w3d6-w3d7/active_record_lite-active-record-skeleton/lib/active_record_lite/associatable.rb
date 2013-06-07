require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
    @other_class
  end

  def other_table
    @other_table_name
  end
end

class BelongsToAssocParams < AssocParams
  attr_reader :primary_key, :foreign_key

  def initialize(name, params)
   @other_class = 
      if params[:class_name]
        params[:class_name].camelize.constantize
      else
        name.to_s.singularize.camelize.constantize
      end
    @other_table_name = other_class.table_name
    @primary_key = 
      if params[:primary_key]
         params[:primary_key].to_s
      else 
         "id"
       end
    @foreign_key = 
      if params[:foreign_key]
        params[:foreign_key].to_s
      else
         "#{name}_id"
       end
  end

  def type
    :belongs_to
  end
end

class HasManyAssocParams < AssocParams
  attr_reader :primary_key, :foreign_key

  def initialize(name, params, self_class)
    @other_class = 
      if params[:class_name]
        params[:class_name].camelize.constantize
      else
        name.to_s.singularize.camelize.constantize
      end
    @other_table_name = other_class.table_name
    @primary_key = 
      if params[:primary_key]
         params[:primary_key].to_s
      else 
         "id"
       end
    @foreign_key = 
      if params[:foreign_key]
        params[:foreign_key].to_s
     else 
      "#{self_class.to_s.underscore}_id"
      end
  end

  def type
    :has_many
  end
end

module Associatable
  def assoc_params
    @assoc_params ||= {}
    @assoc_params
  end

  def belongs_to(name, params = {})
    define_method(name) do

      aps = BelongsToAssocParams.new(name, params)
      self.class.assoc_params[name] = aps

      query = <<-SQL
        SELECT *
        FROM #{aps.other_table}
        WHERE #{aps.other_table}.#{aps.primary_key} = ?
      SQL

      aps.other_class.parse_all(DBConnection.execute(query, self.send(aps.primary_key)))
    end
  end

  def has_many(name, params = {})
    define_method(name) do

      aps = HasManyAssocParams.new(name, params, self.class)
      self.class.assoc_params[name] = aps

      query = <<-SQL
        SELECT *
        FROM #{aps.other_table}
        WHERE #{aps.other_table}.#{aps.foreign_key} = ?
      SQL

      aps.other_class.parse_all(DBConnection.execute(query, self.send(aps.primary_key)))
    end
  end

  def has_one_through(name, assoc1, assoc2)
    define_method(name) do
      params1 = self.class.assoc_params[assoc1]
      params2 = params1.other_class.assoc_params[assoc2]

      if (params1.type == :belongs_to) && (params2.type == :belongs_to)
        pk1 = self.send(params1.foreign_key)
        query = <<-SQL
          SELECT #{params2.other_table}.*
          FROM #{params1.other_table} JOIN #{params2.other_table}
          ON #{params1.other_table}.#{params2.foreign_key}=#{params2.other_table}.#{params2.primary_key}
          WHERE #{params1.other_table}.#{params1.primary_key}=?
        SQL

        params2.other_class.parse_all(DBConnection.execute(query, pk1)).first
      end
    end
  end
end
