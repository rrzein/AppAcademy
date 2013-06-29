class UpVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id

  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, :presence => true
  validate :already_voted
  validate :cant_vote_for_own_post

  def already_voted
    if UpVote.where(:user_id => user_id, :post_id => post_id).first
      errors[:votes] << "You can only vote once."
    end
  end

  def cant_vote_for_own_post
    if self.post.user.id == user_id
      errors[:voter] << "You can't vote for your own post."
    end
  end

end
