module HairTrigger
  module ProperConnection
    extend ActiveSupport::Concern

    class_methods do
      def with_proper_connection
        old_connection = ActiveRecord::Base.octopus_establish_connection.connection.instance_variable_get('@config')
        begin
          ActiveRecord::Base.octopus_establish_connection("shard_sw_#{Rails.env}")
          yield
        ensure
          ActiveRecord::Base.octopus_establish_connection(old_connection)
        end
      end
    end
  end
end
