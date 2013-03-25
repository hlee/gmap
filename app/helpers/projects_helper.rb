module ProjectsHelper
  def fetch_info location
    project = Project.where(location: location)
    project.name
  end
end
