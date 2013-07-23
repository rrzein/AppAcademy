class QuestionFollower
  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT questions.id, questions.title, questions.body, questions.author_id
      FROM users
      JOIN question_followers
          ON users.id = question_followers.follower_id
        JOIN questions
          ON (question_followers.question_id = questions.id)
      WHERE users.id = ?
    SQL

    options_array = db(query, user_id)
    options_array.map { |question_hash| Question.new(symbolify_keys(question_hash)) }
  end

  def self.followers_for_question_id(question_id)
    query = <<-SQL
      SELECT *
      FROM question_followers
      JOIN users
        ON (question_followers.follower_id = users.id)
      WHERE question_id = ?
    SQL

    options_array = db(query, question_id)
    options_array.map { |follower_hash| User.new(symbolify_keys(follower_hash)) }
  end

  def self.most_followed_questions(n)
    query = <<-SQL
      SELECT questions.title, questions.body
      FROM questions
      JOIN question_followers
        ON (questions.id = question_followers.question_id)
      GROUP BY questions.title, questions.body
      ORDER BY COUNT(question_followers.follower_id) DESC
      LIMIT ?;
    SQL

    options_array = db(query, n)
    options_array.map { |question_hash| Question.new(symbolify_keys(question_hash)) }
  end

  def self.symbolify_keys(hash)
    sym_hash = {}
    hash.each { |key, value| sym_hash[key.to_sym] = value }
    sym_hash
  end

  def self.db(*args)
    QuestionsDatabase.instance.execute(*args)
  end

  attr_reader :follower_id, :question_id

  def initialize(options = {})
    @follower_id = options[:follower_id]
    @question_id = options[:question_id]
  end

end