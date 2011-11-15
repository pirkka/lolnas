class ApiUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :lockable, :recoverable, :rememberable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :confirmable, :trackable, :validatable

  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  protected

  def password_required?
    false
  end
end
