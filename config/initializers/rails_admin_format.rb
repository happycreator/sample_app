module RailsAdmin 
  module Config 
    module Fields 
      module Types 
        class Datetime < RailsAdmin::Config::Fields::Base
          register_instance_option :date_format do 
            :default
          end
        end
        class Date < RailsAdmin::Config::Fields::Types::Datetime 
          register_instance_option :date_format do 
            :default
          end
        end
      end 
    end 
  end
end