class User < ApplicationRecord
  belongs_to :user_department
  belongs_to :status

  before_validation :set_password_encrypt
  before_update :set_update_password_encrypt

  def self.validate_login(email, password)
    user = User.where("email = '#{email}'").first
    if user && user.password_digest == Digest::MD5.hexdigest(password)
      user
    else
      nil
    end
  end

  private
    def set_password_encrypt
      return unless self.new_record?
      self.password_digest = Digest::MD5.hexdigest(self.password_digest)
    end

    def set_update_password_encrypt
      self.password_digest = Digest::MD5.hexdigest(self.password_digest)
    end
end
