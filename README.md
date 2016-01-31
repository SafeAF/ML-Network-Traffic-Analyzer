# Development
BareMetal Networks Phase I product development master repository

## 1) Overview & TODO

All non web app related projects here. Upon maturity and with full test suite they are to be submitted to product engineering repo (engineering) for review by committee to get approval to deploy in production.


TODO
-----
Writeup dev tools section, what ones are preferrred and how to install and configure them. 
Gemlists which are prefrerred and why
Which gems are stable which are pessimistic and which are fragile -> how you should speicfiy version in Gemfile
Writeup on available infrastrucutre, dbs servers etc and why and when you should use which over another etc
Document all the api keys we use and how to get from various services.


### API Keys

#### Rubygems

API ACCESS

Your API key is xxxxxxxxxxxxxxxxxxxxxxxxxxxx.

If you want to use gem commands from the command line, you'll need a ~/.gem/credentials file, which you can generate using the following command:

curl -u YOurUserNAME https://rubygems.org/api/v1/api_key.yaml > ~/.gem/credentials; chmod 0600 ~/.gem/credentials

## 3) Tuning Your Dev Rig to The Max

+ Use (#20) apt-build to rebuild your system from source. Yes i said that correctly, rebuild yoru binary linux distro as a source distro like gentoo. +10 horsepower!
+ Edit (#21) sysctl.conf with higher performance settings for virtual mem, network etc.    (See black book on security and performance for the complete workup)
+ Install memlockd ureadahead ulatencyd to auto tweak your system for incerased performance and usability
+ 


### Edit Systectl.conf #21 ###

vm.swappiness=1
Vm.dirty.bg centisecs
And other vm controlling stuff

### ruby garbage collection optimizations
+Find out the best and or optimal settings.for ruby gc
+Upping some.values.iirc need.to search for posts on.the subject.ine.in.particular shud b bookmarked.
