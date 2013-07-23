class Question
  def self.find_by_question_id(question_id)
    query = <<-SQL
      SELECT *
      FROM questions
      WHERE id = ?
    SQL

    Question.new(symbolify_keys(db(query, question_id).first))
  end

  def self.find_by_title(title)
    query = <<-SQL
      SELECT *
      FROM questions
      WHERE title = ?
    SQL

    Question.new(symbolify_keys(db(query, title).first))
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.find_by_author_id(author_id)
    query = <<-SQL
      SELECT *
      FROM questions
      WHERE author_id = ?
    SQL

    options_array = db(query, author_id)
    options_array.map { |author_hash| User.new(symbolify_keys(author_hash)) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
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
  attr_accessor :title, :body, :author_id

  def initialize(options = {})
    @id = options[:id]
    @title = options[:title]
    @body = options[:body]
    @author_id = options[:author_id]
  end

  def author
    User.find_by_id(id)
  end

  def replies
    Reply.find_by_subject_question_id(id)
  end

  def followers
    QuestionFollower.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

  def save
    if id
      update = <<-SQL
        UPDATE questions
        SET title = ?, body = ?, author_id = ?
        WHERE id = ?
      SQL
      QuestionsDatabase.instance.execute(update, title, body, author_id, id)
    else
      insert = <<-SQL
        INSERT INTO questions (title, body, author_id)
        VALUES (?, ?, ?)
      SQL
      QuestionsDatabase.instance.execute(insert, title, body, author_id)
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end
end