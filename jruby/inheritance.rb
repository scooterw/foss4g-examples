# $CLASSPATH << '/path/to/file.jar' puts JAR on CLASSPATH
# require '/path/to/file.jar' works as well
$CLASSPATH << 'jars/jts-1.13.jar'

# Allow use of Java class in JRuby: java_import path.to.JavaClass
# See also: RenamedClass = path.to.JavaClass
java_import com.vividsolutions.jts.geom.GeometryFactory
java_import com.vividsolutions.jts.geom.Coordinate
JTSPoint = com.vividsolutions.jts.geom.Point

# Ruby classes may inherit directly from Java classes
class Point < com.vividsolutions.jts.geom.Point
  def initialize(*coords)
    puts coords
    c = Coordinate.new coords.first, coords.last
    p = GeometryFactory.new.create_point c
    super p.coordinate_sequence, GeometryFactory.new
  end
end

# Ruby classes may inherit directly from Java classes
class ReassignmentPoint < JTSPoint
  def initialize(*coords)
    c = Coordinate.new coords.first, coords.last
    p = GeometryFactory.new.create_point c
    super p.coordinate_sequence, GeometryFactory.new
  end
end

point = Point.new 1, 1

# puts object_instance calls #to_s on object
# JRuby will call #toString on Java object automatically
puts point

# This will be the Ruby class
puts point.class

# This will be the (super) Java class
puts point.java_class

reassignment_point = ReassignmentPoint.new 1, 1

# puts object_instance calls #to_s on object
# JRuby will call #toString on Java object automatically
puts reassignment_point

# This will be the Ruby class
puts reassignment_point.class

# This will be the (super) Java class
puts reassignment_point.java_class
