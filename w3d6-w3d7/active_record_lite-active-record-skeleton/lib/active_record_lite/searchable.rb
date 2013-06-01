require_relative './db_connection'

module Searchable
  def where(params)
  	keys = params.keys.map { |key| "#{key.to_s} = ?" }.join(" AND ")
  	values = params.values

  	query = <<-SQL
  		SELECT *
  		FROM #{table_name}
  		WHERE #{keys}
  	SQL

  	parse_all(DBConnection.execute(query, *values))
  end
end