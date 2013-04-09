class Department
  include Mongoid::Document
  embeds_many :projects
  field :name, type: String
  def self.all_projects
    self.all.to_a.map{|x|x.projects}.flatten
  end
end