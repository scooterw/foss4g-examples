require 'rgeo'

# srid defaults to 4055 if not specified
factory = RGeo::Geographic.spherical_factory(srid: 4326)

# create point using factory
point = factory.point 1, 0

puts point
puts "SRID: #{point.srid}"
