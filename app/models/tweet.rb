class Tweet < ApplicationRecord

belongs_to :user

validates :description, presence: true
validates :description, length: { maximum: 280}
has_many :likes

#Satelite Smart Gucci
end
