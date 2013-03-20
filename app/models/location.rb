class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :project
  field :latitude, type: String
  field :longitude, type: String
end
