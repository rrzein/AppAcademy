class URLShorten
  cattr_accessor :user

  def self.login(email)
    self.user = User.find_or_create_by(:email => email)
  end

  def self.shorten(long_url)
    long = LongUrl.find_or_create_by(:url => long_url)
    short = ShortUrl.create(:long_url_id => long.id, :submitter_id => self.user.id)

    puts "http://awesome.com/#{short.url}"
  end

  def self.expand(short_url)
    short = ShortUrl.find_by_url(short_url)
    display_comments(short)

    Launchy.open(short.long_url.url)
  end

  def self.find_by_user_email(email)
    user = User.find_by_email(email)
    ShortUrl.where(:submitter_id => user.id)
  end

  def self.comment(short_url_id, comment)
    Comment.new(:short_url_id => short_url_id, :body => comment, :author_id => self.user.id)
  end

  def self.display_comments(short_url)
    short_url.comments.each do |comment|
      puts comment.body
    end
  end

  def self.most_popular_by_tag(tag_name)
    tag_topic = TagTopic.find_by_name(tag_name)
    # taggings = Tagging.where(:tag_topic_id => tag_topic.id)
    taggings = tag_topic.taggings

    taggings.max_by do |tagging|
      Visit.where(:short_url_id => tagging.short_url_id).length
    end
  end


end

class TooManyUrlsTooSoon < ActiveModel::Validator
  def validate(record)

    unless where("created_at > ? AND user_id = ?", Time.now - 600, :submitter_id).length < 5
      record.errors[:short_url_id] << "Too many URLs too soon."
    end
  end
end