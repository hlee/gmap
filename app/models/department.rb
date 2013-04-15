class Department
  include Mongoid::Document
  embeds_many :projects
  field :name, type: String
  def self.all_projects
    self.all.to_a.map{|x|x.projects}.flatten
  end

  def self.fetch_projects params
    options = %w(salinity temperature oxygen saturation)
    department_id = params[:department] rescue self.first.id
    option_id = params[:parameter] rescue 0
    start_value = params[:start_value] rescue 0
    end_value = params[:end_value] rescue 100
    filter = options[option_id.to_i].to_sym
    self.where(id: department_id).first.projects.where(filter.gt => start_value.to_f, filter.lt => end_value.to_f).to_a
  end
  
  def self.sum_salinity
    map = %Q{
      function() {
        emit(this._id, {books: this.books});
      }
    }
    reduce = %Q{
      function(key, values) {
        var result = {salinity: 0};
        values.forEach(function(value){
          value.forEach(function(project){
            result.salinity += project.salinity;
          });
        });
        return result;
      }
    }
    Project.map_reduce(map, reduce).out(inline: true)
  end
end