class CourseSerializer < ActiveModel::Serializer
  type :course

  attributes :id, :title
  has_many :topics
  belongs_to :user
end
