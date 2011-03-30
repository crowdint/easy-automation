module EasyAutomation
  class Args
    class << self
      def parse args
        Args.usage if args.include?('--help')
        args.each do |arg|
          var_name = arg.split('=')
          begin
          eval(%{
             EasyAutomation::Runner.configuration.#{var_name[0].gsub('--', '')} = "#{var_name[1]}"
          })
          rescue Exception => e
            Args.usage
            break
          end

        end
      end

      def usage
        puts "Easy Automation"
      end
    end
  end
end