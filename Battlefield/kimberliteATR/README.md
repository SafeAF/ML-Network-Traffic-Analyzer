# KiMBeRLiTe ReAdME

__Underview__

Rails powered Web User Interface and Upstream Configurator for client server node attrition daemons. Backed by the 3 
heavyweights Redis MySQL and MongoDB. If you think its overkill consider that we have the infrastructure in place, 
no excuse not to use it. Pushing 110 Datamodels inherited from [BMN] Supermodels Gem by way of CallGirl, 
that sexy biscuit.Lol. Major relevant models are User, Server, Node < Server, Subscription, InstanceConfig.

__TiTAN Supercluster and Application Deployment Environment__


# Contents of Notable Documents in Kimberlite (other than readme)

# Contents of This Document

+ Overview
+ Vision
+ Design
+ Architecture
+ Implementation

+ Testing

+ Benchmarking/Profiling/Debugging





# Overview

# Vision

# Design


# Architecture



# Implementation



# Testing

Using rspec-rails cucumber(not fully integrated into test workflow yet) shoulda-matchers. 

Improved errors with better_errors gem

# Benchmarking Profiling and Hardcore Debugging 

With rbkit rbtrace allocation tracer stack prof pry byebug web-console. Also rack-mini-profiler

# Procedure Used to Derive Kimberlite From CallGirl

Documenting the procedure I used so that it can be turned into a rake task at some point.

Copied Schema
Loaded in to sql
Copied Models
Copied initializers
Seeded db 
Tested
installed bootstrap-sass
installed the majority of gems from callgirl gemfile, selectively
Setup redis, redis-objects
Setup sidekiq
setup mongoid

schema_to_scaffolded the controllers and views

