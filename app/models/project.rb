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
  def to_latlng
    self.location.first.to_s + ", " + self.location.last.to_s
  end
  
  def round_to_latlng
    self.location.first.to_f.round(4).to_s + self.location.last.to_f.round(4).to_s
  end

  def self.fetch_location options
    latlng = options[:lat].to_f.round(4).to_s + options[:lng].to_f.round(4).to_s
    Project.all.select{|x|x.round_to_latlng == latlng}.first.dis_info
  end
  
  def dis_info
    "Name: " + self.name + " \nDescription:" + self.description 
  end
end
