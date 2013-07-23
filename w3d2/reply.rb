class Reply
  def self.find_by_subject_question_id(subject_question_id)
    query = <<-SQL
      SELECT *
      FROM replies
      WHERE subject_question_id = ?
    SQL

    options_array = db(query, subject_question_id)
    options_array.map { |reply_hash| Reply.new(symbolify_keys(reply_hash)) }
  end

  def self.find_by_parent_reply_id(subject_question_id, parent_reply_id)
    query = <<-SQL
      SELECT *
      FROM replies
      WHERE subject_question_id = ? AND parent_reply_id = ?
    SQL

    options_array = db(query, subject_question_id, parent_reply_id)
    options_array.map { |reply_hash| Reply.new(symbolify_keys(reply_hash)) }
  end

  def self.find_by_responder_id(responder_id)
    query = <<-SQL
      SELECT *
      FROM replies
      WHERE responder_id = ?
    SQL

    options_array = db(query, responder_id)
    options_array.map { |reply_hash| Reply.new(symbolify_keys(reply_hash)) }
  end

  def self.symbolify_keys(hash)
    sym_hash = {}
    hash.each { |key, value| sym_hash[key.to_sym] = value }
    sym_hash
  end

  def self.db(*args)
    QuestionsDatabase.instance.execute(*args)
  end

  attr_reader :id
  attr_accessor :subject_question_id, :parent_reply_id, :reply_body, :responder_id

  def initialize(options = {})
    @id = options[:id]
    @subject_question_id = options[:subject_question_id]
    @parent_reply_id = options[:parent_reply_id]
    @reply_body = options[:reply_body]
    @responder_id = options[:responder_id]
  end

  def author
    User.find_by_id(responder_id)
  end

  def question
    Question.find_by_question_id(subject_question_id)
  end

  def parent_reply
    Reply.find_by_parent_reply_id(subject_question_id, parent_reply_id)
  end

  def child_replies
    Reply.find_by_parent_reply_id(subject_question_id, id)
  end

  def save
    if id
      update = <<-SQL
        UPDATE replies
        SET subject_question_id = ?, parent_reply_id = ?,
            reply_body = ?, responder_id = ?
        WHERE id = ?
      SQL
      QuestionsDatabase.instance.execute(update, subject_question_id, parent_reply_id, reply_body, responder_id, id)
    else
      insert = <<-SQL
        INSERT INTO replies (subject_question_id, parent_reply_id,
                             reply_body, responder_id)
        VALUES (?, ?, ?, ?)
      SQL
      QuestionsDatabase.instance.execute(insert, subject_question_id, parent_reply_id, reply_body, responder_id)
      id = QuestionsDatabase.instance.last_insert_row_id
    end
  end
end