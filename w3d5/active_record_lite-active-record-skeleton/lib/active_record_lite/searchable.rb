require_relative './db_connection'

module Searchable
  def where(params)
    keys = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    values = params.values

    query = <<-SQL
    SELECT *
    FROM #{self.table_name}
    WHERE #{keys}
    SQL

    self.parse_all(DBConnection.execute(query, *values))
  end
end