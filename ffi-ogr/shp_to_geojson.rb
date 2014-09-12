require 'ffi-ogr'

# read in Shapefile
shp = OGR.read './data/states.shp'

# output GeoJSON to string
puts shp.to_json

# output GeoJSON to file
shp.to_geojson './data/states.geojson'
