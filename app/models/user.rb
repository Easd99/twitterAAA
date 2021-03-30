class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  def self.find_for_database_authentication(conditions={})
    find_by(username: conditions[:email]) || find_by(email: conditions[:email])
  end

  validates :username, uniqueness: true
  has_many :tasks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self


         
  def self.authenticate(email, user_token)
    where("email  = ? AND authentication_token= ?", email, user_token).first
  end

  def self.authenticateShow(email)
    find_by(email: email)
  end

  def self.jwt_payload
    { 'foo' => 'bar' }
  end

  def self.change_token(user) 
    revoke_jwt(User.jwt_payload,user)
  end

  def self.authenticate_with_password(email, password)
    where("email  = ? AND = encrypted_password= ?", email, user_token).first
  end
         
end
