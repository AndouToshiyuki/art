class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :content, presence: true, length: { maximum: 50 }
  
  has_many :favorites
  has_many :users, through: :favorites, source: :user, dependent: :destroy
  
  
end
