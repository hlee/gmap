module ProjectsHelper
  def fetch_info location
    project = Project.where(location: location)
    project.name
  end
 
  def parameter_options id=0
    options = %w(salinity temperature oxygen saturation)
    arr = []
    options.each_with_index{|x,i|arr << [x, i]}
    options_for_select(arr, [options[id.to_i], id])
  end
 
  def d_name id
    Department.where(id: id).first.name
  end

end
