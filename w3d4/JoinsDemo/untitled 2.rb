JOINS IN ACTIVE RECORD

N+1 selects problem --> Each db query has overhead
-If you wanted to get the number of comments per post, you'd have to query the DB N + 1 times.... too much overhead'

-Specify associations to prefetch in advance--> associations can determine data to be fetched and won't need to be unnecessarily queried for later.'
-Use includes method--> allows you to execute just ONE query, as opposed to N+1 queries)

Complex Includes
-Can prefetch for more than one thing at a time
comments = user.comments.includes(:post, :parent_comment)