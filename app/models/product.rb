class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader
  has_many :line_items

  belongs_to :category

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, presence: true
  validates :category, presence: true
end
