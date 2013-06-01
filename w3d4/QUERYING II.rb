QUERYING II
find_by_sql => use your own SQL to find records in a table
-returns an array of objects
-You could use a heredoc to embed the SQL query

Case.find_by_sql(<<-SQL)
  SELECT cases.*
  FROM cases
  JOIN (
  // the five laywers with the most clients
    SELECT lawyers.*
    FROM lawyers
    LEFT OUTER JOIN clients
    ON lawyers.id = clients.lawyer_id
    GROUP BY lawyers.id
    SORT BY COUNT(clients.*)
    LIMIT 5
)
  ON ((cases.prosecutor_id = lawyer.id) OR (cases.defender_id = laywer.id))
SQL

Dynamic Finders
-Use if you want ActiveRecord to return objects that match some sort of criteria--
- If it comes up with one (or zero) objects, it'll do away' with the annoying array shit surrounding it. So if AR finds one object, it'll just' GIVE you that object, and it won't give you ' [object].
Example:
Application.find_by_email_address("ned@appacademy.io")
Application.find_all_by_current_city("San Francisco")

-AR overrides method_missing?

ORDERING
-Retrieve records from the database in a specific order
-Ex: Client.order("created at DESC") => returns the client orderes in descending order based on when they were created
-Multiple fields: Client.order("orders_count ASC, created_at DESC")

-If you call order multiple times in different context, the following one will prepend (go before) the previous one
Client.order("orders_count ASC").order("created_at DESC")
IS ACTUALLY
Client.order("created at DESC", "orders_count ASC")
-i think. ask to make sure.

GROUP, HAVING
-Can apply Group By and Having clauses.
-Less common.

CALCULATIONS
-All calculations work directly on a model or a relation
-On a model:
-Client.count
#SELECT count(*) AS count_all FROM clients
-On a relation:
Client.where(:first_name => 'Ryan').count
#SELECT count(*) As count_all FROM clients WHERE (first_name = 'Ryan')

-Can user finder methods to perform complex calculations
Client.joins("LEFT OUTER JOIN orders").where(:first_name => 'Ryan', :orders => {:status => 'received'}).count
#EXECUTES
SELECT count(DISTINCT clients.id) AS count_all FROM clients
LEFT OUTER JOIN orders ON orders.client_id = client.id WHERE
(clients.first_name = 'Ryan' AND orders.status = 'received')

CALCULATION TYPES
Count
-Something.count to get a count of how many records are in Something's table'
-If you want to be more specific, pass in argument.
-i.e. Client.count(:age)
-Finds all the clients with the age present in the database

Average
Average of a certain number

Client.average("orders_count")
#orders count is a column of numbers
#returns a number representing the average value in the field

Minimum
-Minimum value of a field in your table
Client.minimum("age")

Maximum
-Maximum value of a field in your table
Client.maximum("age")

Sum
-Sum for a field of all records in your table
Client.sum("orders_count")