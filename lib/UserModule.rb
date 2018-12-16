module UserModule
  @user_id = nil

  def self.set_user_id value
    @user_id = value
  end

  def self.get_user_id
    @user_id
  end
end