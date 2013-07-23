class QuestionLike
  def self.find_by_question_id(question_id)
    query = <<-SQL
      SELECT *
      FROM question_likes
      WHERE question_id = ?
    SQL

    QuestionLike.new(symbolify_keys(db(query, question_id).first))
  end

  def self.find_by_liker_id(liker_id)
    query = <<-SQL
      SELECT *
      FROM question_likes
      WHERE liker_id = ?
    SQL

    QuestionLike.new(symbolify_keys(db(query, liker_id).first))
  end

  def self.likers_for_question_id(question_id)
    query = <<-SQL
      SELECT users.*
      FROM question_likes
      JOIN users
        ON (question_likes.liker_id = users.id)
      WHERE question_likes.question_id = ?
    SQL

    options_array = db(query, question_id)
    options_array.map { |user_hash| User.new(symbolify_keys(user_hash)) }
  end

  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
      SELECT COUNT(liker_id)
      FROM question_likes
      WHERE question_likes.question_id = ?
    SQL

    num_likes = db(query, question_id).first.values[0]
  end

  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT questions.*
      FROM question_likes
      JOIN questions
        ON question_likes.question_id = questions.id
      WHERE question_likes.liker_id = ?
    SQL

    options_array = db(query, user_id)
    options_array.map { |question_hash| Question.new(symbolify_keys(question_hash)) }
  end

  def self.most_liked_questions(n)
    query = <<-SQL
      SELECT questions.*
      FROM question_likes
      JOIN questions
        ON question_likes.question_id = questions.id
      GROUP BY questions.id
      ORDER BY COUNT(liker_id) DESC
      LIMIT ?
    SQL

    options_array = db(query, n)
    options_array.map { |question_hash| Question.new(symbolify_keys(question_hash)) }
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

  attr_reader :question_id, :liker_id

  def initialize(options = {})
    @question_id = options[:question_id]
    @liker_id = options[:liker_id]
  end
end