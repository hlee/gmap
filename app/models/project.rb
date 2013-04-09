class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  #has_one :location
  include Gmaps4rails::ActsAsGmappable
  #include Mongoid::Geo
  embedded_in :department
  field :name, type: String
  field :created_date, type: Date
  field :description, type: String
  field :salinity, type: Float
  field :temperature, type: Float
  field :oxygen, type: Float
  field :saturation, type: Float
  acts_as_gmappable :position => :location, :process_geocoding => false
  field :location, :type => Array
  def to_latlng
    self.location.first.to_s + ", " + self.location.last.to_s
  end
  
  def round_to_latlng
    self.location.first.to_f.round(3).to_s + self.location.last.to_f.round(3).to_s
  end

  def self.fetch_location options
    latlng = options[:lat].to_f.round(3).to_s + options[:lng].to_f.round(3).to_s
    Department.all_projects.select{|x|x.round_to_latlng == latlng}.first.dis_info
  end
  
  def dis_info
    "Name: " + self.name + " \nDescription:" + self.description 
  end
end
