module ProjectsHelper
  def fetch_info location
    project = Project.where(location: location)
    project.name
  end
 
  def parameter_options
    options = %w(salinity temperature oxygen saturation)
    arr = []
    options.each_with_index{|x,i|arr << [x, i]}
    options_for_select arr
  end
end
