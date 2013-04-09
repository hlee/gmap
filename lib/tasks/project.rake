namespace :project do
  desc 'load initial projects related data'
  task bulk_load: :environment do
    lines = File.readlines('public/project_data.csv').map{|x|x.gsub("\n",'')}
    lines.each do |line|
      rs = line.split('|')
      next if rs.blank?
      department_name = rs[0]
      project_name = rs[1]
      latitude = rs[2]
      longitude = 0 - rs[3].to_f
      created_date = DateTime.strptime(rs[4], "%m/%d/%Y")
      description = rs[5]
      salinity = rs[6].to_f
      temperature = rs[7].to_f
      oxygen = rs[8].to_f
      oxygen_saturation = rs[9].to_f
      dept = Department.find_or_create_by(name: department_name)
      dept.projects.create(name: project_name, 
                    created_date: created_date,
                    description: description,
                    salinity: salinity,
                    temperature: temperature,
                    oxygen: oxygen,
                    saturation: oxygen_saturation,
                    location: [latitude, longitude]
          )
    end
  end
end