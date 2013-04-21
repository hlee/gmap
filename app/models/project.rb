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
    "\nName:    " + self.name + 
    "\nDescription:    " + self.description +
    "\nSalinity:    " +  self.salinity.to_s  + "ppt" + 
    "\nTemperature:    " + self.temperature.to_s + "cel" +
    "\nOxygen:    " + self.oxygen.to_s + "mg/l" +
    "\nSaturation:    " + self.saturation.to_s + '%'
  end

  def self.map_reduce1
    #FIXME seems not belongs to here
    map = %Q{
      function() {
        emit(this._id, {salinity: this.salinity});
      }
    }
    reduce = %Q{
      function(key, values) {
        var result = {salinity: 0};
        values.forEach(function(value){
          result.salinity += value.salinity;
        });
        return result;
      }
    }
    Project.map_reduce(map, reduce).out(inline: true)
  end
end
