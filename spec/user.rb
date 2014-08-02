class User
  include Mongoid::Document

  has_many :hoges
end