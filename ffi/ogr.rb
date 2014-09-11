require 'ffi'

module OGR
  extend ::FFI::Library

  def self.search_paths
    ['/usr/local/{lib64,lib}', '/opt/local/{lib64,lib}', '/usr/{lib64,lib}', '/usr/lib/{x86_64,i386}-linux-gnu']
  end

  def self.find_lib(lib)
    Dir.glob(search_paths.map {|path|
      File.expand_path(File.join(path, "#{lib}.#{::FFI::Platform::LIBSUFFIX}"))
    }).first
  end

  # Function definitions
  FUNCTIONS = {
    GDALVersionInfo: [[:string], :string],
    OGRRegisterAll: [[], :void],
    OGRGetDriverCount: [[], :int],
    OGRGetDriver: [[:int], :pointer],
    OGR_Dr_GetName: [[:pointer], :string]
  }
  
  begin
    ffi_lib find_lib('{lib,}gdal{,-?}')

    # Example of attach_function usage
    #attach_function :GDALVersionInfo, [:string], :string

    # Iterate through function definitions and attach using FFI's attach_function
    FUNCTIONS.each do |function, params|
      attach_function function, params.first, params.last
    end

    # Load all available drivers; verify GDAL loaded successfully
    OGRRegisterAll()
  rescue LoadError, NoMethodError
    raise LoadError.new 'Could not load GDAL library'
  end

  class << self
    def gdal_version
      OGR.GDALVersionInfo 'RELEASE_NAME'
    end

    def drivers
      [].tap do |d|
        for i in 0...OGR.OGRGetDriverCount
          d << OGR.OGR_Dr_GetName(OGR.OGRGetDriver(i))
        end
      end
    end

    def loaded?(driver_name)
      drivers.include? driver_name
    end
  end
end

# Check GDAL Version using OGR#gdal_version which calls GDALVersionInfo through FFI
puts "GDAL Version: #{OGR.gdal_version}"
puts ''
puts "ESRI Shapefile driver loaded?: #{OGR.loaded?('ESRI Shapefile')}"
