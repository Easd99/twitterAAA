class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def self.find_for_database_authentication(conditions={})
    find_by(username: conditions[:email]) || find_by(email: conditions[:email])
  end

  validates :username, uniqueness: true
  has_many :tasks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


         
  def self.authenticate(email, user_token)
    where("email  = ? AND authentication_token= ?", email, user_token).first
  end
         
end
