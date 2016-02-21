# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.email = "foo@foo.com"

u.username = 'foo'
u.password = 'foobarfoo'

u.projects << Project.new(name: 'bigproject', description: 'what an awesome project', completion_percentage: '70
.45')

p = u.projects.first
p.issues << Issue.new(name: 'small issue')
#
# s = u.servers << Server.new
#
# s.hostname = 'dev0.titan5.clusterforge.us'
# s.ip = '10.0.1.220'
# s.save!

# i = s.instances << Instance.new
# i.name = 'foo instance'
# i.service = 'apache2'
# i.subscribed = true
# i.subscription = Subscription.new(subscribed: true)
# i.save!
# #
# h = Server.new
#
# h.name = 'serv2'
# h.hostname = 'serv2.foo.com'
# h.ip = '10.0.1.221'
# h.installed = true
# u.servers << h
#
# h.save!
#
# n = h.instances << Instance.new
# n.name = 'foo instance'
# n.service = 'apache2'
# n.subscribed = false
# n.subscription = Subscription.new(subscribed: false)
# n.save!

net = Network.new
net.address_space = "10.0.1.0"
net.save!

t = Titanvserv.new
t.ip = '10.0.1.50'
t.save!

%w{ 10.0.1.51 10.0.1.52 10.1.53}.each do |srv|
  t = Titanserv.new
  t.ip = srv
  t.save!
end

