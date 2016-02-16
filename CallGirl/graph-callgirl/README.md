## CaLLGiRL README

### Overview
Generic Rails App for BareMetal web based user interfaces. Soon will have single
app support via rails websockets and also sinatra and neato backbone.js, angular.js views
for rails.

redis caching: 
redis models:
mongoid models:
alt sql db models:

serialization:
--------------
MessagePack & JSON & BSON (mongo)



Changelist
----------
10/01/15 [v0.1.0] - Initial Release
10/19/15 [v0.2.0] - Extending app models, added 'phrasing' gem. MessagePack



### Further Investigation Needed 

Check out a process monitoring/overlord like foreman or bluepill or god


## TODO ##

*Build up rake tasks*

*Document*

*Graphs*

*More UI Components*

*Tie in logging from SQL DB*  

*Advance Logging Search + Parsing + Sig/Noise SQL ChainsawD*



*AJAXify and add more functionality via coffeescript/js/jquery/jqueryUI*


## Devise TODO

Sessions Helper Methods

Devise is packaged with several helper methods for use throughout your application to control user accessibility:

To redirect non-logged in user from a page:  before_action :authenticate_user!

To verify if a user is signed in:  user_signed_in?

To verify current user:  current_user

You will want to use these functions to control what each user can access.

     *Devise/Auth -> Need tor un rails g devise:views, rails g devise:views users*
Now that you have a dedicated user controller, you can set up corresponding views as you normally would in your views/users directory – index.html.erb, edit.html.erb  and  show.html.erb. In connection with your edit view, you probably want to create a partial for the edit form the way a scaffold would. – _form.html.erb.

You can now create a link to your user’s profile – <%= link_to "Profile", current_user %> - which may contain a link to edit the user’s attributes – <%= link_to "Settings", edit_user_path(@user) %>. Note that this will allow the user to edit any attributes you set (i.e., name, age, etc.). This is separate from the user’s devise settings which control password reset and account cancellation.Now that you have a dedicated user controller, you can set up corresponding views as you normally would in your views/users directory – index.html.erb, edit.html.erb  and  show.html.erb. In connection with your edit view, you probably want to create a partial for the edit form the way a scaffold would. – _form.html.erb.
                                                                                                                                                                                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                                                                                                                                                         You can now create a link to your user’s profile – <%= link_to "Profile", current_user %> - which may contain a link to edit the user’s attributes – <%= link_to "Settings", edit_user_path(@user) %>. Note that this will allow the user to edit any attributes you set (i.e., name, age, etc.). This is separate from the user’s devise settings which control password reset and account cancellation.


## Noteworthy Features

*Redis powered caching including sessions*

*Mysql, MongoDB, Redis*

*File and Directory Virtual FS using GridFS and Mongo*

*Sidekiq for background jobs*

*Bootstrap and AdminLTE*

*Thin, Puma and Unicorn supported*


### Plugins
*Powersaw -> Syslog Viewing + Fulltext Search + AJAX
*Grits -> Critical log entries/monitoring daemon messages + queque + topbar 
alarm/notification messagebox populator




## Components of CallGirl


### Models and Database Support

*MySQL & ActiveRecord* 

*MongoDB+Mongoid*

*Redis+Redis::Objects*

Huge list of models supported, the majority being sql/ar because the schema
must be defined before-hand  (unlike with mongo or redis) and the idea here
is to save developer time in the long run.


### Views 

*Supports ERB (.html.erb) and Markdown (.md)*
Use markdown for content heavy views without the need for html markup/tags. Works
well to extract the markdown content into partions and <% render :markdown_partial_name %>
so that you can use html markup in the rest of the view but not pollute the lovely 
and sleek markdown content for whoever is so lucky to work on that part.

#### Frameworks

*Bootstrap 3*
Full bootstrap 3 is available in CallGiRL #2 and #3, includding several font sets like
font-awesome and ionicons as well as glyphicons. See bootstrap 3 docs for info
located at [Bootstrap3](http://bootstrap.com) and also check out the bootstrap
code snippet archive/playground thingy [Bootsnip](http://bootsnip.com) and also
[BootstrapStage](http://bootstrapstage.com) for freeish.


*AdminLTE v2.1*
Sleek and sexy buildabear webapp type backend and/or administration dashboard 
toolkit built ontop of bootstrap.

*DevOOPS*
Similar to AdminLTE2 check out zBMNForks for our copy of DevOOPS
                           
    Dashboad Layout
    xCharts
    Flot Charts
    Google Charts
    Morris Charts
    Google Maps Integration
    Multilevel Menu
    Table Structures
    Widget Elements

*SBAdmin v2.0* 

    Morris.js for fully custom charts
    Bootsnip page elements added:
    Timeline, Chat, Login Page
    Circle Outline and Social Buttons

### Controllers


#### Authentication and Authorization via User/Group
Built out our own user model with authentication, and authorization through rights
and roles tables. In addition there is a new (and untested) group model.
 
#### GridFS Pseudo Filesystem
and group models are paired together to provide a pseudo filesystem ontop of
gridfs (mongodb feature).

## Blonde or Brunette or Redhead? Pick Your CallGirl Poison
+CallGirl/

++OnDash-CallGirl/   -> Most extensive use of view components available, AdminLTE.
 Examples of all the various view components are available in app/views/shared

++BootStrapped-CallGirl/  -> Bootstrap components available in app

++LowRent-CallGirl/  -> Basic, ten bucks to Ride the Rails. Comes with jquery support, 
 and a large selection of models.

++SinatrasCallGirl/ -> Sinatra framework (this is not rails!) + Bootstrap


## Directory Structure
  

* App/Views/Pages ->  static pages 
 
        put them in the RAILS_ROOT/app/views/pages directory.
        
        $ mkdir app/views/pages
        $ touch app/views/pages/about.html.erb
        
        After putting something interesting there, you can link to it from anywhere in your app with:
        
        link_to 'About', page_path('about')
      
        Copy
        
        You can nest pages in a directory structure, if that makes sense from a URL perspective for you:
        
        link_to 'Q4 Reports', page_path('about/corporate/policies/HR/en_US/biz/sales/Quarter-Four')
        
        Copy
        
        Bam.
        
        You can also get a list of your static pages by calling HighVoltage.page_ids This might be useful if you need to build a sitemap. For example, if you are using the sitemap_generator gem, you could add something like this to your sitemap config file:
        
        HighVoltage.page_ids.each do |page|
          add page, changefreq: 'monthly'
        end


### Development Process

###= Gems

*Check out awesome_print for printing ugly objects

*And Better_errors for rails errors

## Deployment

* Ruby version -> 2.2.1 Preferred although anything over 1.9.0 is compatible
at the sourcecode level

* System dependencies -> From apt-get - libmysqlclient-dev libmysqlclient18 nodejs + rvm from rvm.io

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Installing CallGirl
 
*Pull down CallGirl from svn or git*

*apt-get install libmysqlclient-dev libmysqlclient18 nodejs*

*Install rvm from rvm.io and the latest ruby or 2.2.1 and rails 4.2.1*

*You may not really need to do all that since the gems and ruby vers are packaged in vendor/ this is done to ensure it wont break randomly*

*Ensure you have access to stack0 for redis*

*Ensure access to datastore0 or datastore1 for production (fortress for extremely high demand i/o sites), and datastore2 for dev*



### Configure ActiveRecord MySQL Database

You shouldnt need to do this, unless you didnt get a database.yml or mongoid.yml with your callgirl

default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: callgirl
  host: datastore2
  password: pass
  url: "mysql2://callgirl:pass@datastore2"

development:
  <<: *default
  database: callgirl_development

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: callgirl_test

 As with config/secrets.yml, you never want to store sensitive information,
 like your database password, in your source code. If your source code is
 ever seen by anyone, they now have access to your database.

 Instead, provide the password as a unix environment variable when you boot
 the app. Read http://guides.rubyonrails.org/configuring.html#configuring-a-database
 for a full rundown on how to provide these environment variables in a
 production deployment.

 On Heroku and other platform providers, you may have a full connection URL
 available as an environment variable. For example:

   DATABASE_URL="mysql2://myuser:mypass@localhost/somedatabase"

 You can use this database configuration with:
 
   production:
    url: <%= ENV['DATABASE_URL'] %>

production:
  <<: *default
  database: callgirl_production
  username: webui
  password: <%= ENV['WEBUI_DATABASE_PASSWORD'] %>
  
### Database Models

Including ActiveRecord, Mongoid, and Redis::Objects Models
account.rb
application.rb
audittrail.rb
ban.rb
cluster.rb
combined.rb
common_meta.rb
concerns
conf.rb
connection.rb
database.rb
datastructstor.rb
development.rb
devops.rb
directory.rb
doc_category.rb
document.rb
file.rb
group.rb
harddrive.rb
hardware.rb
infrastructure.rb
instance.rb
inventory.rb
item.rb
language.rb
logentry.rb
logfile.rb
logofuser.rb
machine.rb
manager.rb
message.rb
nethardware.rb
network.rb
node.rb
notification.rb
operations.rb
page.rb
privkey.rb
process.rb
project.rb
pubkey.rb
research.rb
right.rb
role.rb
schema.rb
server.rb
service.rb
statistic.rb
table.rb
user.rb


### MongoDB and Mongoid

Mongo DB is schemaless but sometimes you need a easy mechanism to transform
strings into the appropriate type. Use the field macro for this

    class Person
    ...
      field :name, type: String
    end

Valid 'field' types

    Array
    BigDecimal
    Boolean
    Date
    DateTime
    Float
    Hash
    Integer
    BSON::ObjectId
    BSON::Binary
    Range
    Regexp
    String
    Symbol
    Time
    TimeWithZone


### Mongoid on Rails

    Mongoid provides some railties and initializers for rails apps!
    
   
#### Configuration

Set config options in application.rb by referencing config.mongoid, overrides mongoid.yml

          module CallGirl
           class Application < Rails::Application
            config.mongoid.logger = Logger.new($stdout, :warn)
            config.mongoid.persist_in_safe_mode = true
           end
          end
          
          
          

#### Rake Tasks

The rake task db:create_indexes is the only way to create indexes for mongodb.
Mongoid provides the following rake tasks when used in a Rails 3 environment:

    db:create: Exists only for dependency purposes, does not actually do anything.
    db:create_indexes: Reads all index definitions from the models and attempts to create them in the database.
    db:remove_indexes: Reads all secondary index definitions from the models.
    db:drop: Drops all collections in the database with the exception of the system collections.
    db:migrate: Exists only for dependency purposes, does not actually do anything.
    db:purge: Deletes all data, including indexes, from the database. Since 3.1.0
    db:schema:load: Exists only for framework dependency purposes, does not actually do anything.
    db:seed: Seeds the database from db/seeds.rb
    db:setup: Creates indexes and seeds the database.
    db:test:prepare: Exists only for framework dependency purposes, does not actually do anything.




## Mongoid Map Reduce


Mongoid provides a DSL around MongoDB’s map/reduce framework, for performing custom map/reduce jobs or simple aggregations.
Execution

You can tell Mongoid off the class or a criteria to perform a map/reduce by calling map_reduce and providing map and reduce javascript functions.

map = %Q{
  function() {
    emit(this.name, { likes: this.likes });
  }
}

reduce = %Q{
  function(key, values) {
    var result = { likes: 0 };
    values.forEach(function(value) {
      result.likes += value.likes;
    });
    return result;
  }
}

Band.where(:likes.gt => 100).map_reduce(map, reduce).out(inline: true)

Just like criteria, map/reduce calls are lazily evaluated. So nothing will hit the database until you iterate over the results, or make a call on the wrapper that would need to force a database hit.

Band.map_reduce(map, reduce).out(replace: "mr-results").each do |document|
  p document # { "_id" => "Tool", "value" => { "likes" => 200 }}
end

The only required thing you provide along with a map/reduce is where to output the results. If you do not provide this an error will be raised. Valid options to #out are:
                          
 
 

    inline: 1: Don’t store the output in a collection.
    replace: "name": Store in a collection with the provided name, and reduce all existing results in that collection.

    merge: "name": Store in a collection with the provided name, and merge the results with the existing documents.
    reduce: "name": Store in a collection with the provided name, and overwrite any documents that exist in it.        



## SideKiq & Background Processing



Using Redis

Your Workers are encouraged to use Sidekiq's Redis connection pool in their work. Sidekiq's Redis connection pool is optimized for multithreaded usage; using it ensures your code is safe and performant, even under heavy load.

To use Redis, just wrap all operations in Sidekiq.redis {|conn| ... }

class MyWorker
  include Sidekiq::Worker

  def perform(count)
    Sidekiq.redis do |conn|
      conn.incrby('foo', count)
    end
  end
end





##Messaging Notification and Queques




Critlarm system utilizes sql queque in a pinch or redis queuque if its 
available and populates the topbar alarm and notification widgets.

Critlarm has_many queques, queques has many plates.

