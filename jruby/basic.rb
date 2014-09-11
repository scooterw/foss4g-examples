# require '/path/to/file.jar' puts JAR on CLASSPATH
# $CLASSPATH << '/path/to/file.jar' works as well
require 'jars/jts-1.13.jar'

# Allow use of Java class in JRuby: java_import path.to.JavaClass
# See also: RenamedClass = path.to.JavaClass
java_import com.vividsolutions.jts.geom.GeometryFactory
java_import com.vividsolutions.jts.geom.Coordinate

# Java classes may be used with Ruby Object conventions
point = Java::ComVividsolutionsJtsGeom::GeometryFactory.new.create_point Java::ComVividsolutionsJtsGeom::Coordinate.new(1,1)
puts point

# Java classes may also be used with Java conventions
point = com.vividsolutions.jts.geom.GeometryFactory.new.create_point com.vividsolutions.jts.geom.Coordinate.new(1,1)

# puts object_instance calls #to_s on object
# JRuby will call #toString on Java object automatically
puts point

# Java classes may be used without the java class path if java_import is used
# or if class is renamed using assignment
point = GeometryFactory.new.create_point Coordinate.new(1,1)

# puts object_instance calls #to_s on object
# JRuby will call #toString on Java object automatically
puts point
