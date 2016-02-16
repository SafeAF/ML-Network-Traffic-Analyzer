# Switchyard PostServ v0.2.0
__Description__

| Switchyard Service | Deployed to |Port Range | Transport Proto | Encoding |
|----------|----------|-------|-----|----------|----|
| PostServ | AppServ0-5 |7000-7005 | HTTPS | JSON |
| Switchyard | AppServ3-9 | 8000-8005 | HTTPS | JSON |
| Bloodlust | AppServ 5-9 | - | Redis | JSON |


PostServ  is an exposed API for Attrition Clients that handles the submission of logs and pcap files for processing by the machine learning backend into actionable IDS events. It is ruby on rack and dosed with sinatra::base.

# Introduction

The main functionality of PostServ is to receive post requests from attrition clients. After verifying apiuuid and apikey logs are submitted to redis for either pre processing via sidekiq workers for later processsing by bloodlust machine learner; or immediate retrieval by bloodlust.
LogServ is a sinatra api running on rack powered by thin and written in ruby. While the optimal number of thin servers per core still needs to be profiled we have defaulted to 5 with a concurrency of ~1000 and a max connections ceiling of ~10000. Obviously this should be tested with ab (apachebench from apache-utils apt package) and optimal settings found and recorded here and wherever else is appropriate.

# Deployment

  + Initial version 0.2.0 deployed to app3
  + Redis server: stack0 (10.0.1.75)
  + Mongodb server: datastore0 (10.0.1.30) -> Not in use yet

## Running PostServ
 Change server settings like port and listener in production-thin.yml. Application settings are in config.ru but you shouldn't have to mess with them unless the database servers change addressses or something like that.

  **thin -C production-thin.yml -R config.ru start**


  **bundle exec sidekiq -r ./switchkiqworkers.rb**

## Installation

  Run bundle install after changing into the logserv directory.

    $ bundle install

## Configuration

  + Change application settings in config.ru and production-thin.yml.

  + Database settings are in database.yml and/or mongoid.yml.

   + Mandatory redis settings are in config.ru.

   + __As of the first pre-release v0.2.0 only redis is required.__

   + Eventually mongodb and very likely mysql via activerecord will be dependencies as well.


# Benchmarking

Use apache bench from apache-utils apt package to benchmark PostServ on the front end side (the side clients connect to). We are testing concurrency, requests per second, transfer rate, and time per request.

__Run all of these tests simultaneously__

     ab -n <requests> -c <concurrency> <url:port>

     ab -n 10000 -c 100 http://10.0.1.50:7000/status

     ab -n 1000 -c 100 http://serverlocation:7000 &
     ab -n 1000 -c 100 http://serverlocation:7001 &
     ab -n 1000 -c 100 http://serverlocation:7002 &
     ab -n 1000 -c 100 http://serverlocation:7003 &
     ab -n 1000 -c 100 http://serverlocation:7004 &

