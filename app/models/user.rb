class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  has_many :wikis

  #roles: standard = 0, premium = 1, admin = 2
  enum role: [:standard, :premium, :admin]

  #automatically register a user as a standar user
  after_initialize :init_role

  #saves user email as a downcase version and sends the welcome email
  before_save { self.email = email.downcase if email.present? }
  after_create :send_confirmation_email

  #

  #user validations
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password,
      presence: true,
      length: { minimum: 6 }
  validates :password,
      length: { minimum: 6 },
      allow_blank: true
  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { minimum: 3, maximum: 254 }



  def init_role
    self.role ||= :standard
  end

  private

  def send_confirmation_email
    UserMailer.new_user(self).deliver_now
  end

end
