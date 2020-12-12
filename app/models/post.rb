class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 50 }
  
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites
  has_many :users, through: :favorites, source: :user, dependent: :destroy
end
