JOINS IN ACTIVE RECORD

N+1 selects problem --> Each db query has overhead
-If you wanted to get the number of comments per post, you'd have to query the DB N + 1 times.... too much overhead'

-Specify associations to prefetch in advance--> associations can determine data to be fetched and won't need to be unnecessarily queried for later.'
-Use includes method--> allows you to execute just ONE query, as opposed to N+1 queries)

Complex Includes
-Can prefetch for more than one thing at a time
comments = user.comments.includes(:post, :parent_comment)

Can also do "nested" prefetches
  posts = user.posts.includes(:comments => [:author, :parent_comment])

JOINS
-Perform a SQL join by using joins
-Takes a name of an association (like includes)
-Performs INNER JOIN by default

-JOINS is kind of like the opposite of "includes"

INCLUDES can also return lots of DATA, which we might not want!
-Includes is wasteful when we just want to AGGREGATE the data, not FETCH all of it
-Use JOINS when we want to do an aggregation
-You can use SELECT to get extra information... You'll still 'receive the same object (posts), but you can call a new method that includes the extra information you called for in SELECT

-Perform OUTER JOINS by giving joins a SQL fragment
-i.e. posts.joins("LEFT OUTER JOIN comments ON posts.id = comments.post.id")

-Can specify WHERE conditions on the joined tables.
Use special HASH syntax.

#fetch comments on 'Posts' posted in previous day
#btw... Time.now.midnight gets the time
time_range = (Time.now.midnight - 1.day)..Time.now.midnight
Comment.joins(:posts).where('posts.created_at' => time_range)

can also use
Comment.joins(:posts).where(:posts => { :created_at => time_range } )

SCOPES
-Common to wrap a long query in a method
-Even better to write queries as a class method

SCOPES - keep your query code DRY
-MOVE FREQUENTLY USED, COMPLICATED QUERIES into a scope.