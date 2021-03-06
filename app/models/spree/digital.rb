module Spree
  class Digital < ActiveRecord::Base
    belongs_to :variant
    has_many :digital_links, :dependent => :destroy

    s3_credentials =
      if Rails.env.test?
        {:access_key_id => 'a', :secret_access_key => 'b', :bucket => 'c'}
      elsif File.exist? File.join(Rails.root, 'config', 's3.yml')
        File.join(Rails.root, 'config', 's3.yml')
      else
        {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => ENV['S3_BUCKET']}
    end


    has_attached_file :attachment,
                      :url => ':s3_domain_url',
                      :path => ":basename.:extension",
                      :storage => :s3,
                      :s3_credentials => s3_credentials,
                      :s3_permissions => 'authenticated-read',
                      :s3_protocol => 'https'

    # TODO: Limit the attachment to one single file. Paperclip supports many by default :/

    def authenticated_url(expires_in = Spree::DigitalConfiguration[:authorized_days].days)
      #attachment.s3_object(nil).url_for(:read,
      attachment.s3_object.url_for(:read,
                                   :expires => expires_in,
                                   :use_ssl => attachment.s3_protocol == 'https' ).to_s
    end

    attr_accessible :variant_id, :attachment
  end
end
