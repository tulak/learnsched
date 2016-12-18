class LoginForm
  include ActiveModel::Model

  attr_reader :email, :password, :logged_user
  def initialize params={}
    @email = params[:email].to_s.strip
    @password = params[:password]
  end

  def login
    user = User.where(email: email).first
    unless user
      errors.add :base, "User not found"
      return false
    end

    unless user.password == User.encrypt_password(password)
      errors.add :base, "Incorrect password"
      return false
    end

    @logged_user = user
    true
  end
end