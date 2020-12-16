class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 50 }
  
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :favorites
  has_many :users, through: :favorites, source: :user, dependent: :destroy
  
  def save_tag(savepost_tags)
  current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
  old_tags = current_tags - savepost_tags
  new_tags = savepost_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << post_tag
    end
  end
end
