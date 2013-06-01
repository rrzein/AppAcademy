class Visit < ActiveRecord::Base
  #need to add the validators
  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true

  belongs_to :user
  belongs_to :short_url

  [:user_id,
   :short_url_id].each { |field| attr_accessible field }

   def self.record_visit(user, shortened_url)
     Visit.create(:user_id => user.id, :shortened_url_id => shortened_url.id)
   end

end
