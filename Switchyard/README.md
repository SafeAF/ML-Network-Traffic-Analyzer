# switchyard
middleware server

# Getting Switchyard Deployed #

First make sure all the gems that are needed are in the _switchyard_ gemfile not any other
gemfile! and make sure that rvm is installed if not see the attached script and how
it is done. Then run rvm use @default or create a gemset for switchyard. Then bundle install.

Finally to start the server use
$ rackup -b 0.0.0.0 -p <desired port>

In summary:

* know the ip of the mysql master in sql cluster datastore0 10.0.1.17 as of Aug2015
* know the ip of stack0 in redis system stack for the supercluster  10.0.1.17
* modify either database.yml or inside the server.rb file to reflect the right addrs
* install -> rvm
* bundle install -> in gem directory
* create/load gemset
* execute (with desired values) -> rackup



