spec = Gem::Specification.new do |s|
  s.name = 'ec2-instance'
  s.version = '0.0.10'
  s.date = '2011-1-16'
  s.summary = 'Extension for amazon-ec2 gem for instance operations'
  s.email = "berrydigital@gmail.com"
  s.homepage = "http://github.com/bdigital/ec2-instance"
  s.description = "Monkey patch some amazon-ec2 gem classes and modules to handle common operations."
  s.has_rdoc = false
  s.executables = []
  s.authors = ["Robert Berry"]
  s.add_dependency('amazon-ec2')
  s.files = ["lib/ec2-instance.rb", "lib/instance.rb", "README"]
end

