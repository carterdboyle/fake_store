class Product < ApplicationRecord
  class OutOfStockError < StandardError; end

  def decrement_if_available(qty)
    qty = qty.to_i
    return true if qty <= 0

    affected = Product.where(id: id)
                      .where(Product.arel_table[:amount].gteq(qty))
                      .update_all(["amount = amount - ?", qty])
    affected == 1
  end

  def decrement_if_available!(qty)
    decrement_if_available(qty) or raise OutOfStockError, "Not enough stock!"
  end
end
