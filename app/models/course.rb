class Course < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  belongs_to :user
end
