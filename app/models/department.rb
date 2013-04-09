class Department
  include Mongoid::Document
  embeds_many :projects
end