# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.username = 'foo'
u.password = 'bar'
s = u.servers << Server.new
s.name = 'serv1'
s.hostname = 'serv1.foo.com'
s.ip = '10.0.1.220'
s.save!

i = s.instances << Instance.new
i.name = 'foo instance'
i.service = 'apache2'
i.subscribed = true
i.subscription = Subscription.new(subscribed: true)
i.save!

h = u.servers << Server.new
h.name = 'serv2'
h.hostname = 'serv2.foo.com'
h.ip = '10.0.1.221'
h.installed = true
h.save!

n = h.instances << Instance.new
n.name = 'foo instance'
n.service = 'apache2'
n.subscribed = false
n.subscription = Subscription.new(subscribed: false)
n.save!
