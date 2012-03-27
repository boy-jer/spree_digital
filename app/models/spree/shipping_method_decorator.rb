Spree::ShippingMethod.class_eval do

  # Indicates whether or not the category rules for this shipping method
  # are satisfied (if applicable)
  def category_match?(order)
    return true if shipping_category.nil?

    return false if self[:name].downcase.include?('download') and not order.digital?

    if match_all
      order.products.all? { |p| p.shipping_category == shipping_category }
    elsif match_one
      order.products.any? { |p| p.shipping_category == shipping_category }
    elsif match_none
      order.products.all? { |p| p.shipping_category != shipping_category }
    end
  end

end
