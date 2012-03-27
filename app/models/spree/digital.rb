module Spree
  class Digital < ActiveRecord::Base
    belongs_to :variant
    has_many :digital_links, :dependent => :destroy

    has_attached_file :attachment, :path => ":rails_root/private/digitals/:basename.:extension"

    # has_attached_file :attachment,
    #                   :url => ':s3_domain_url',
    #                   :path => "assets/digitals/:id/:basename.:extension",
    #                   :storage => :s3,
    #                   :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    #                   :s3_permissions => 'authenticated-read',
    #                   :s3_protocol => 'https'

    # TODO: Limit the attachment to one single file. Paperclip supports many by default :/

    # def download_url(include_updated_timestamp = true)
    #   url = Paperclip::Interpolations.interpolate('/:id/:basename.:extension', attachment)
    #   include_updated_timestamp && attachment.updated_at ? [url,
    #     attachment.updated_at].
    #     compact.join(url.include?("?") ? "&" : "?") : url
    # end

    # def authenticated_url(expires_in = 3.days)
    #   AWS::S3::S3Object.url_for(attachment.path,
    #                             attachment.bucket_name,
    #                             :expires_in => expires_in,
    #                             :use_ssl => attachment.s3_protocol == 'https' )
    # end
  end
end
