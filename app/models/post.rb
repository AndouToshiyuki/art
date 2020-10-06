class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validate  :picture_size
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  has_many :users, through: :favorites, source: :user, dependent: :destroy
  
  private
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
