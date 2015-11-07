# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

i = Infrastructure.new(name: 'Titan SuperCluster')
n = Network.new
c = Cluster.new(name: 'Application Cluster 0')
i.clusters << c
u = User.find_or_create_by(name: 'boo-bees', username: 'foo', password: 'bar')
s = Server.find_or_create_by(ip: '10.0.1.14', hostname: 'app0',
                             virtual: true,
                             os: 'Ubuntu 14.04 LTS',
														 type: 'MetalStack-1.0.0 Application Server')

c << s
m2 = Machine.find_or_create_by(ip: '10.0.1.42')
u.servers << s
u.machines << m2

u.save!


