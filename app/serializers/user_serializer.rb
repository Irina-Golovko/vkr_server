class UserSerializer < ActiveModel::Serializer
  type :user

  attributes :id, :name, :email, :role, :authentication_token
end
