class TopicSerializer < ActiveModel::Serializer
  type :topic

  attributes :id, :title
  has_many :documents
  belongs_to :course
  belongs_to :user
end
