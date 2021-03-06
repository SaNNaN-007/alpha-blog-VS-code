class Article < ApplicationRecord
  
  belongs_to :user

  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :article_categories, presence: true

  validates :title, presence: true, length: {minimum: 3 , maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 3000}
  validates :user_id, presence: true
  
end