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
  has_many :likes
  has_many :messages
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

  def like(tweet_id)
    
    likes.where(tweet_id: tweet_id)

  end
  def followers()
    followers = Friendship.where(friend_user_id: id)
    @followerslist=[]
    followers.each do |follower|
        users = User.where(id: follower.user_id)
        users.each do |user|
            @followerslist.push({id: user.id, username: user.username})
        end
    end
    return @followerslist

  end

  def follower?(friend_id)
    Friendship.where(user_id:friend_id , friend_user_id: id).first
  end

  def followers()
    Friendship.where(friend_user_id: id)
  end

  def follow?(friend_id)
    Friendship.where(user_id: id , friend_user_id: friend_id).first
  end

  def followings()
    Friendship.where(user_id: id)
  end

  def followersAndfollowing()
    list = Friendship.where(friend_user_id: id).or(Friendship.where(user_id: id))
    @all = []

    list.each do |l|
      if l.user_id == id
        user = User.where(id: l.friend_user_id)
      else
        user = User.where(id: l.user_id)
      end

      user.each do |u|
        @all.push({id: u.id, username: u.username})
      end

    end
    
    return @all

  end
         
end
