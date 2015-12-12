This is a demo Sinatra app using the following technologies:

  + Mongoid (persistence)
  + Bourbon and Neat (design)
  + Rspec + Capybara (testing)
  + Pry (inspection)


The directory structure I went for is a lightweight attempt to get the most out
of all these amazing technologies. Please fork and comment. To get things going, I recommend the following:

  + `review the structure (especially assets directory)`
  + To start the server: `rackup -p 4567`
  + Compile CSS from SCSS: `sass --watch assets:public/stylesheets -r ./assets/bourbon/lib/bourbon.rb`
  + Install the Heroku Addon for MongoHQ `heroku addons:add mongohq:sandbox`
  + Follow docs [here](https://devcenter.heroku.com/articles/mongohq#additional-documentation)
