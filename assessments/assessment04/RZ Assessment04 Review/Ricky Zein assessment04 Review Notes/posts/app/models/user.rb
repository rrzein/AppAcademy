class User < ActiveRecord::Base
  attr_accessible :password, :session_token, :username
  validates :username, :presence => true
  validates :password, :presence => {:error => "Password can't be blank"}
  #could have used a custom validator
  validates :password, :length => { :minimum => 6,
  										:error => "Password is too short (minimum is 6 characters)" }

  has_many :posts, :class_name => "Post"

  #can put the log-in, log-out, current_user, and verify_user methods in the ApplicationHelper

	def verify_password(password)
		self.password == password
	end

	def reset_session_token
		self.session_token = SecureRandom.urlsafe_base64(16)
		self.save!
	end

	def logout
		self.session_token = nil
		self.save!
	end

end

#custom_validator
# def password_long_enough!
#   if password.length < 6
#     errors[:password] << "Password is too short"
#   end
# end
