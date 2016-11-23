class Post < ApplicationRecord
  belongs_to :user

  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true
end
