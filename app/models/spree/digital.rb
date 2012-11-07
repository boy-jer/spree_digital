module Spree
  class Digital < ActiveRecord::Base
    belongs_to :variant
    has_many :digital_links, :dependent => :destroy

    has_attached_file :attachment,
                      :url => ':s3_domain_url',
                      :path => ":basename.:extension",
                      :storage => :s3,
                      :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
                      :s3_permissions => 'authenticated-read',
                      :s3_protocol => 'https'

    # TODO: Limit the attachment to one single file. Paperclip supports many by default :/

    def authenticated_url(expires_in = Spree::DigitalConfiguration[:authorized_days].days)
      attachment.s3_object(nil).url_for(:read,
                                        :expires => expires_in,
                                        :use_ssl => attachment.s3_protocol == 'https' ).to_s
    end

    attr_accessible :variant_id, :attachment
  end
end