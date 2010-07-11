#!/bin/sh
sudo gem uninstall ec2-instance
gem build ec2-instance.gemspec
sudo gem install $(ls ec2-instance*.gem|tail -n 1)
