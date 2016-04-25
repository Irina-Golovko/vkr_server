class Topic < ActiveRecord::Base
  has_many :documents, :dependent => :destroy
  belongs_to :course
  belongs_to :user
end
