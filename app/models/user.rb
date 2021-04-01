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


  def generate_jwt(jti)
    JWT.encode({id: id, exp: 30.days.from_now.to_i, jti: jti}, Rails.application.secret_key_base)
  end
         


end
