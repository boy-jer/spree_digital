module Spree
  class DigitalsController < Spree::BaseController

    ssl_required :show

    def show
      link = Spree::DigitalLink.find_by_secret(params[:secret])
      if link.present? and link.digital.attachment.present?
        attachment = link.digital.attachment

        if link.authorize!
          redirect_to link.digital.authenticated_url
          return
        else
          Rails.logger.error "Missing Digital Item: #{attachment.path}"
        end
      end
      render :unauthorized
    end
  end
end
