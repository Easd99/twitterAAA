class Tweet < ApplicationRecord

belongs_to :user

validates :description, presence: true
validates :description, length: { maximum: 280}
has_many :likes
has_one_attached :image, dependent: :destroy

end
