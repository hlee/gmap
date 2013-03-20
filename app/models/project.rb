class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  has_one :location
  field :name, type: String
  field :created_at, type: Time
  field :description, type: String
end
