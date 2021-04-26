class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :friendships,
      class_name: "User", 
      join_table:  :friendships, 
      foreign_key: :user_id, 
      association_foreign_key: :friend_user_id

  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  def self.find_for_database_authentication(conditions={})
    find_by(username: conditions[:email]) || find_by(email: conditions[:email])
  end

  validates :username, uniqueness: true
  has_many :tweets
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self


         
  def self.authenticate(email, user_token)
    where("email  = ? AND authentication_token= ?", email, user_token).first
  end

  def self.authenticateShow(email)
    find_by(email: email)
  end


  def generate_jwt()
    JWT.encode({id: id, exp: 30.days.from_now.to_i, jti: jti}, Rails.application.secret_key_base)
  end
         
end
