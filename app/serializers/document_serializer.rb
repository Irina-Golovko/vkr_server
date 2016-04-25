class DocumentSerializer < ActiveModel::Serializer
  type :document

  attributes :id, :title, :link, :description, :text, :css
  belongs_to :topic
  belongs_to :user
  has_many :images
end
