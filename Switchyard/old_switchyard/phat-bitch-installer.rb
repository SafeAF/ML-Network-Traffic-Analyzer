#!/bin/sh

echo "OMGZ PHIZZATNESS"
apt-get update
apt-get install ruby-connection-pool ruby-mysql2 thin  ruby-hiredis ruby-redis


gem install sinatra
gem install rack
gem install redis-objects
gem install active-record