# bonus

class Tag
  def self.most_popular
    query = <<-SQL
      SELECT tags.tag_name as tag_name, questions.*
      FROM (SELECT question_likes.question_id as qid,
            COUNT(question_likes.liker_id) as qlikescount
            FROM question_likes
            GROUP BY question_likes.question_id)
      JOIN questions
        ON qid = questions.id
      JOIN question_tags
        ON qid = question_tags.question_id
      JOIN tags
        ON question_tags.tag_id = tags.id
      GROUP BY tags.id
      ORDER BY qlikescount DESC;
      SQL

      # need to find a new way to cycle through our result
      # and display. currently returns two objects (tag_name & question)


      # options_array = db(query)
      # options_array.map { |tag_hash| Tag.new(symbolify_keys(tag_hash)) }
  end

  def self.symbolify_keys(hash)
    sym_hash = {}
    hash.each { |key, value| sym_hash[key.to_sym] = value }
    sym_hash
  end

  def self.db(*args)
    QuestionsDatabase.instance.execute(*args)
  end

  def initialize(options = {})
    @id = options[:id]
    @tag_name = options[:tag_name]
    @most_popular_question = options[:most_popular_question]
  end
end