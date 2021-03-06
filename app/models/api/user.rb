class Api::User < ActiveRecord::Base
  self.table_name = "api_users"

  # Include default devise modules. Others available are:
  # :encryptable, :lockable, :recoverable, :rememberable, :timeoutable and :omniauthable
#  devise :database_authenticatable,
  devise :registerable, :token_authenticatable,
         :confirmable, :trackable, :validatable

  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email#, :password, :password_confirmation, :remember_me

  attr_accessor :password

  has_many :restaurants, :foreign_key => "api_user_id"

  def display_name
    email
  end

  protected

  def password_required?
    false
  end
end
