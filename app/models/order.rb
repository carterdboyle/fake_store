class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  before_validation :ensure_public_id, on: :create

  private
  def ensure_public_id
    self.public_id ||= SecureRandom.hex(8)
  end
end