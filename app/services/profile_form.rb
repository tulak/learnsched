class ProfileForm
  include ActiveModel::Model

  attr_reader :password, :password_confirmation, :first_name, :last_name, :user
  def initialize user, params={}
    @user = user
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @first_name = params[:first_name] || user.first_name
    @last_name = params[:last_name] || user.last_name
  end

  validates :password, confirmation: true, presence:  true, if: proc {|f| f.password.present? }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def save
    return false unless valid?

    user.password = User.encrypt_password(password) if password.present?
    user.first_name = first_name
    user.last_name = last_name
    user.save!
  end
end