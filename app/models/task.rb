class Task < ApplicationRecord

belongs_to :user

validates :description, presence: true
validates :description, length: { maximum: 280}

#Satelite Smart Gucci
end
