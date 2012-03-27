module Spree
  class DigitalsController < Spree::BaseController

    ssl_required :show

    def show
      link = Spree::DigitalLink.find_by_secret(params[:secret])
      if link.present? and link.digital.attachment.present?
        # if link.authorize!
        #   redirect_to link.digital.authenticated_url
        #   return
        # end
        if link.authorize! and File.file?(attachment.path)
          send_file attachment.path :filename => attachment.original_filename, :type => attachment.content_type and return
        end
      end
      render :unauthorized
    end

  end
end