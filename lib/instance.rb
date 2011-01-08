module AWS
  module EC2
    class Instance

      attr_accessor :instance_id, :launch_time, :status, :tags, :dns

      def initialize(init_hash = {})
        init_hash.each do |k, v|
          self.send(k.to_s + "=", v) unless !self.respond_to?(k.to_s + "=")
        end
      end

      def match?(tag)
        self.tags.detect { |k, v| v.to_s.match /#{tag}/ }
      end  

    end
  end
end

