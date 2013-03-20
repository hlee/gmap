class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  #has_one :location
  include Gmaps4rails::ActsAsGmappable
  #include Mongoid::Geo
  field :name, type: String
  field :created_at, type: Time
  field :description, type: String
  acts_as_gmappable :position => :location, :process_geocoding => false
  field :location, :type => Array
end
