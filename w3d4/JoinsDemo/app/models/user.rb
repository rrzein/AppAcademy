class User < ActiveRecord::Base
  [ :user_name,
    :first_name,
    :last_name ].each do |field|
    attr_accessible field
    validates field, :presence => true
  end

  has_many :posts, :foreign_key => :author_id
  # SELECT *
  #   FROM posts
  #  WHERE posts.author_id = #{self.id}
  has_many :comments, :foreign_key => :author_id
  # SELECT *
  #   FROM comments
  #  WHERE comments.author_id = #{self.id}

  # A `has_many :through` association: it builds new associations out
  # of existing ones. It "traverses" two associations, first it gets
  # the posts, then it gets the comments on those posts. Note that
  # `posts` is the name of a `User` association, and `comments` is the
  # name of a `Post` association.
  #
  # If the name of this association had been `comments`, Rails would
  # have guessed the second (`source`) association.
  has_many :post_feedback, :through => :posts, :source => :comments

  def n_plus_one_post_comment_counts
    posts = self.posts
    # SELECT *
    #   FROM posts
    #  WHERE posts.author_id = #{self.id}

    post_comment_counts = {}
    posts.each do |post|
      # this query gets performed once for each post. each db query
      # has overhead, so this is very wasteful if there are a lot of
      # `Post`s for the `User`.
      post_comment_counts[post] = post.comments.count
      # SELECT *
      #   FROM comments
      #  WHERE comments.post_id = #{post.id}
    end

    post_comment_counts
  end

  def includes_post_comment_counts
    # `includes` *prefetches the association* `comments`, so it doen't
    # need to be queried for later. `includes` does not change the
    # type of the object returned (in this example, `Post`s); it only
    # prefetches extra data.
    posts = self.posts.includes(:comments)
    # Makes two queries:
    # SELECT *
    #   FROM posts
    #  WHERE post.id = #{self.id}
    # ...and...
    # SELECT *
    #   FROM comments
    #  WHERE comments.id IN (...fetched post ids go here...)

    post_comment_counts = {}
    posts.each do |post|
      # doesn't fire a query, since already prefetched the association
      # way better than N+1
      post_comment_counts[post] = post.comments.count
    end
  end

  def self.users_with_comments
    # `joins` can be surprising to SQL users. When we perform a SQL
    # join, we expect to get "wider" rows (with the columns of both
    # tables). But `joins` does not automatically return a wider row;
    # User.joins(:comments) still just returns a User.
    #
    # In this sense, `joins` does the opposite of `includes`:
    # `includes` fetches the entries and the associated entries
    # both. `User.joins(:comments)` returns no `Comment` data, just
    # the `User` columns. For this reason, `joins` is used less
    # commonly than `includes`.

    User.joins(:comments)
    # SELECT users.* -- note that only the user fields are selected!
    #   FROM users
    #   JOIN comments
    #     ON comments.author_id = users.id

    # `User.joins(:comments)` returns an array of `User` objects; each
    # `User` appars once for each `Comment` they've made. A `User`
    # without a `Comment` will not appear (`joins` defaults to INNER
    # JOIN). We could write `User.joins(:comments).uniq` to return a
    # `User` exactly once if he had made any comment.
  end

  def joins_post_comment_counts
    # We use `includes` when we need to prefetch an association and
    # use those associated records. If we only want to *aggregate* the
    # associated records somehow, `includes` is wasteful, because all
    # the associated records are pulled down into the app.
    #
    # For instance, if a `User` has posts with many, many comments, we
    # would pull down every single comment. This may be more rows than
    # our Rails app can handle. And we don't actually care about all
    # the individual rows, we just want the count of how many there
    # are.
    #
    # When we want to do an "aggregation" like summing the number of
    # records (and don't care about the individual records), we want
    # to use `joins`.

    posts_with_counts = self
      .posts
      .select("posts.*, COUNT(*) AS comments_count") # more in a sec
      .joins(:comments) # .joins("LEFT OUTER JOINS comments")
      .group("posts.id") # "comments.post_id" would be equivalent
    # in SQL:
    #   SELECT posts.*, COUNT(*) AS comments_count
    #     FROM posts
    #    JOINS comments
    #       ON comments.post_id = posts.id
    #    WHERE posts.author_id = #{self.id}
    # GROUP BY posts.id

    # As we've seen before using `joins` does not change the type of
    # object returned: this returns an `Array` of `Post` objects.
    #
    # But we do want some extra data about the `Post`: how many
    # comments were left on it. We can use `select` to pick up some
    # "bonus fields" and give us access to extra data.
    #
    # Here, I would like to have the datbase count the comments per
    # post, and store this in a column named `comments_count`. The
    # magic is that ActiveRecord will give me access to this column by
    # dynamically adding a new method to the returned `Post` objects;
    # I can call `#comments_count`, and it will access the value of
    # this column:

    posts_with_counts.map do |post|
      # `#comments_count` will access the column we `select`ed in the
      # query.
      [post.title, post.comments_count]
    end
  end
end
