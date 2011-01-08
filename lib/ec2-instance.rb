# 
# All methods added to AWS::EC2::Base return values and initiate actions for the machine
#   on which the process is running.
#
Dir[File.join(File.dirname(__FILE__), '*.rb')].each { |lib| require lib }

module AWS
  module EC2
    class Base

      #
      # Returns an array of instance ids which have a running or pending status
      #
      def active_instances
        instances = []

        parse_instance_set(self.describe_instances).each do |instance|
          if instance.status == "running" || instance.status == "pending"
            instances.push instance
          end
        end 
       
        return instances
      end

      #
      # Return a list of active instances which have a tag value which regexp matches.
      #
      def instances_active_with_tag(tag)
        matches = []
        active_instances.each do |ai|
          matches.push ai unless !ai.match?(tag)
        end
        return matches
      end

      #
      # Return the launch time of this machine.
      #
      def launch_time
        local_instance = parse_instance_set(self.describe_instances).detect do |inst|
          inst.instance_id.eql? AWS::EC2::Instance.local_instance_id
        end

        return local_instance.launch_time
      end

      private

      def parse_instance_set(ec2_response_hash)
        instances = []
        ec2_response_hash["reservationSet"]["item"].each do |res|
          res["instancesSet"]["item"].each do |i|
            instances.push AWS::EC2::Instance.new({:instance_id => parse_instance_id(i), :status => parse_status(i), :launch_time => parse_launch_time(i), :tags => parse_tags(i)})
          end
        end
        return instances
      end

      def parse_launch_time(instance_hash)
        Time.parse(instance_hash["launchTime"]).localtime
      end

      def parse_instance_id(instance_hash)
        instance_hash["instanceId"]
      end

      def parse_status(instance_hash)
        instance_hash["instanceState"]["name"]
      end
  
      def parse_tags(instance_hash)
        return [] unless !instance_hash["tagSet"].nil?
        instance_hash["tagSet"]["item"]
      end

    end
  end
end
