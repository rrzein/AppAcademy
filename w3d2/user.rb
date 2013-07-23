class User
  def self.find_by_id(user_id)
    query = <<-SQL
      SELECT *
      FROM users
      WHERE id = ?
    SQL

    User.new(symbolify_keys(db(query, user_id).first))
  end

  def self.find_by_name(fname, lname)
    query = <<-SQL
      SELECT *
      FROM users
      WHERE fname = ? AND lname = ?
    SQL
    User.new(symbolify_keys(db(query, fname, lname).first))
  end

  private

  def self.symbolify_keys(hash)
    sym_hash = {}
    hash.each { |key, value| sym_hash[key.to_sym] = value }
    sym_hash
  end

  def self.db(*args)
    QuestionsDatabase.instance.execute(*args)
  end

  public

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options = {})
    @id = options[:id]
    @fname = options[:fname]
    @lname = options[:lname]
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_responder_id(id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_use_id(id)
  end

  def average_karma
    query = <<-SQL
      SELECT AVG(likes_num)
      FROM (
        SELECT COUNT(question_likes.liker_id) as likes_num
        FROM questions
        JOIN question_likes
          ON questions.id = question_likes.question_id
        WHERE questions.author_id = ?
        GROUP BY question_likes.question_id
      )
    SQL

    avg_likes = db(query, id).first.values[0]
  end

  def save
    # debugger
    if id
      update = <<-SQL
        UPDATE users
        SET fname = ?, lname = ?
        WHERE id = ?
      SQL
      QuestionsDatabase.instance.execute(update, fname, lname, id)
    else
      insert = <<-SQL
        INSERT INTO users (fname, lname)
        VALUES (?, ?)
      SQL
      QuestionsDatabase.instance.execute(insert, fname, lname)
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end
end