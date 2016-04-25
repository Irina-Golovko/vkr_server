class UserWithoutTokenSerializer < ActiveModel::Serializer
  type :user

  attributes :id, :name, :email, :role
end
