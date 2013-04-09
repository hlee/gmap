class Department
  include Mongoid::Document
  embeds_many :projects
  field :name, type: String
end