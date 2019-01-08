class User < ApplicationRecord
  belongs_to :user_department
  belongs_to :status

  def self.validate_login(email, password)
    user = User.where("email = '#{email}'").first
    if user && user.password_digest == Digest::MD5.hexdigest(password)
      user
    else
      nil
    end
  end
end
