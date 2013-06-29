class FriendCircle < ActiveRecord::Base
  attr_accessible :name, :user_id, :member_ids

  belongs_to :user
  has_many :memberships, :dependent => :destroy

  has_many :members, :through => :memberships

  has_many :post_shares
  has_many :postings, :through => :post_shares, :source => :post
end
