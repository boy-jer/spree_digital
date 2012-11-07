Spree::Order.class_eval do

  # Are all products/variants of this Order to be downloaded by the customer?
  def digital?
    line_items.map { |item| return false unless item.digital? }
    true
  end

  # Is at least one product/variant digital?
  def some_digital?
    line_items.map { |item| return true if item.digital? }
    false
  end

  # Determine which method to use for shipping of digital products.
  def digital_shipping_method
    rates = rate_hash
    # If there is a shipping method has "Download" in its name then we take that one.
    rates.each { |rate| return rate if rate[:name].downcase.include?('download') }
    # Other than that, we take the first one that we find that doesn't cost anything.
    rates.each { |rate| return rate if rate[:cost] == 0 }
    # Well, at this point we have a problem. No shipping method is cost-free or called "download".
    nil
  end

  def reset_digital_links!
    line_items.select(&:digital?).map(&:digital_links).flatten.each do |digital_link|
      digital_link.update_column :access_counter, 0
      digital_link.update_column :created_at, Time.now
    end
  end

  # UPGRADE_CHECK this works as of spree 1.2.0. check function for changes on upgrade
  def available_shipping_methods(display_on = nil)
    return [] unless ship_address
    all_methods = Spree::ShippingMethod.all_available(self, display_on)

    if self.digital?
      all_methods.detect { |m| m.calculator.class == Spree::Calculator::DigitalDelivery }.try { |d| [d] } || all_methods
    else
      all_methods
    end
  end
end
