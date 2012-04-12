module Spree
  class SpreeDigitalConfiguration < Preferences::Configuration
    preference :authorized_clicks,  :integer, :default => 3
    preference :authorized_days,    :integer, :default => 3
  end
end