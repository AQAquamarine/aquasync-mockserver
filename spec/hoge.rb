require 'aquasync_model'

class Hoge
  include Aquasync::Base

  field :hoge
  belongs_to :user
end