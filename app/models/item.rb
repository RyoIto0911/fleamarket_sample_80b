class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, dependent: :destroy
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", optional: true
  has_many :item_images, dependent: :destroy
  
  accepts_nested_attributes_for :item_images, allow_destroy: true, update_only: true
  
  belongs_to :user, dependent: :destroy, optional: true
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :delivery_origin

  validates :name, presence: true, length: { maximum: 40 }
  validates :introduction, presence: true, length: { maximum: 1000 }
  validates :price, presence: true
  validates :condition_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :delivery_origin_id, presence: true
  validates :delivery_date_id, presence: true
  validates :category_id, presence: true
  validates :item_images, presence: true

 

  def self.search(search)
    if search
      Item.where('title LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end
end
