# Crowd Interactive Copyright 2011

#
# Class to map keys to attributes
# @author: Edwin Cruz (edwin.cruz@crowdint.com)
#
module EasyAutomation
  class DataElements

    #
    # Builds magic functions to handle elements
    # @params hash key => value
    #
    def initialize(elements)
      @elements = {}
      @elements.merge!(elements || {})
      @elements.each do |key, value|
        if (value.class.to_s == "Array" || value.class.to_s == "Hash")
          eval (%{
            def #{key}
              return @elements[:#{key}]

            end
          })
        elsif value.class.to_s == 'Fixnum'
          eval(%{
            def #{key}
              return #{value}
            end
          })
        else
          eval(%{
            def #{key}
              return #{value.dump}
            end
          })
        end
      end
    end
  end
end