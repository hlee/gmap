# Display Google map api with mongo db

# How to run

* localhost:3000/projects
* create projects with location(lat and lon)

# Basic Configuration

```ruby

acts_as_gmappable

def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  "#{self.street}, #{self.city}, #{self.country}" 
end
```

# table change

```ruby
add_column :users, :latitude,  :float #you can change the name, see wiki
add_column :users, :longitude, :float #you can change the name, see wiki
add_column :users, :gmaps, :boolean #not mandatory, see wiki
```

# main Non-relational DB

```ruby
acts_as_gmappable :position => :location

field :location, :type => Array
```

# Quick Display

```ruby
#In your controller:

@json = User.all.to_gmaps4rails
#In your view:

<%= gmaps4rails(@json) %>
```
