module AWS
  module EC2
    class Instance

      attr_accessor :connection
      attr_accessor :instance_id, :launch_time, :status, :tags, :dns

      def initialize(init_hash = {})
        init_hash.each do |k, v|
          self.send(k.to_s + "=", v) unless !self.respond_to?(k.to_s + "=")
        end
      end

      def match?(tag)
        self.tags.detect {|h| h.detect { |k, v| v.to_s.match /#{tag}/ } }
      end

      #
      # If connection available, terminate self.
      #
      def self_destruct
        raise "No Connection Associated With This Instance." unless !@connection.nil?
        @connection.terminate_instances(:instance_id => self.instance_id)
        # Have a Nice Day.
      end

    end
  end
end

