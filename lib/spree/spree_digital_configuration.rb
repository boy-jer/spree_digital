module Spree
  class SpreeDigitalConfiguration < Preferences::Configuration
    preference :authorized_clicks,  :integer, :default => 100
    preference :authorized_days,    :integer, :default => 3
    preference :expires_in,         :integer, :default => 1
  end
end