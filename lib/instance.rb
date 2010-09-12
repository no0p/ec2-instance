module AWS
	module EC2
    # TODO change to instance once upstream namespace resolved  
		class Instancex
			
			attr_accessor :instance_id, :launch_time, :status

			def initialize(init_hash = {})
				init_hash.each do |k, v|
					self.send(k.to_s + "=", v.to_s) unless !self.respond_to?(k.to_s + "=")
				end
			end

		end

	end
end

