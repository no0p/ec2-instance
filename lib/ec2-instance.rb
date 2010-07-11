# 
# All methods added to AWS::EC2::Base return values and initiate actions for the machine
#   on which the process is running.
#

module AWS
  module EC2
    class Base

      #
      # Return the launch time of this machine.
      #
      def launch_time
        instance_data = parse_instance_set(self.describe_instances).detect do |inst|
          inst.to_s.include? AWS::EC2::Instance.local_instance_id
        end

        launched_time = Time.parse(parse_launch_time(instance_data)).localtime
        return launched_time
      end

      private

      def parse_instance_set(ec2_response_hash)
        ec2_response_hash["reservationSet"]["item"]
      end

      def parse_launch_time(instance_hash)
        instance_hash["instancesSet"]["item"].first["launchTime"]
      end

    end
  end
end
