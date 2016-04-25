class Document < ActiveRecord::Base
  mount_uploader :file, DocumentUploader
  mount_uploader :css, CssUploader
  belongs_to :topic
  belongs_to :user
  has_many :images, :dependent => :destroy
end
