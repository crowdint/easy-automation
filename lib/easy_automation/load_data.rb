# Crowd Interactive Copyright 2011

#
# Loads Test Data or Elements XPaths
# @author Edwin Cruz (edwin@crowdint.com)
#
module EasyAutomation
  class LoadData

    #
    # Loads test data based on test name.
    # @params name string filename to load data
    # @params path base path to find '/data/' folder
    # @returns associative array containing at method level its test data
    #
    def self.load_test_data(name, test_name, path)
      data      = YAML::load(File.read(File.join(path, 'data', "#{name}.yml")))
      DataElements.new(data[test_name])
    end

    #
    # Loads xpath elements based on page name.
    # @params name string filename to load data
    # @params path base path to find '/elements/' folder
    # @returns associative array containing element's xpath
    #
    def self.load_xpath_elements(name, path)
      DataElements.new(YAML::load(File.read(File.join(path, 'elements', "#{name.downcase}.yml"))))
    end
  end
end