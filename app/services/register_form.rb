class RegisterForm
  include ActiveModel::Model

  attr_reader :email, :password, :password_confirmation, :first_name, :last_name, :registered_user
  def initialize params={}
    @email = params[:email].to_s.strip
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
  end

  validates :password, confirmation: true, presence:  true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def register
    return false unless valid?
    @registered_user = User.create!(
        email:      email,
        password:   User.encrypt_password(password),
        first_name: first_name,
        last_name:  last_name
    )

  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.messages.each do |field, messages|
      messages.each do |message|
        errors.add field, message
      end
    end
    false
  end
end