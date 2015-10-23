namespace :doc do
  desc "document db: (annotate, schema.rb, dot)"
  task :db=>%w(annotate_models db:schema:dump doc:dot)

  desc "Use railroad to generate graphviz dot files"
  task :dot do
    #tack on stuff at the top of the page
    FORMAT=%q{sed 's/graph\\[/  graph[page="8.5,11",\
            size="7.5,10",center=1];\
    node[shape=Mrecord,width="1.2",fillcolor="#cccccc",\
            style="filled", penwidth="2"]\
    edge [ minlen="1.2", penwidth="2"]\
    graph[/'}
  
    now=`rake db:version`.chomp.split(' ')[-1]
    models="doc/models#{now}.dot"
    #hide magic hides created_at, updated_at
   puts `railroad -liM --hide-magic|#{FORMAT}>#{models}`
  
    [models].each do |filename|
      filetype='pdf'
      outfile=filename.gsub('.dot',".#{filetype}")
      #create viewable file (graphviz must be installed)
      puts `dot -T#{filetype} #{filename} -o#{outfile}`

      #open the file using mac graphviz app
      puts `open #{filename} -a graphviz`
    end
  end
end

#################

tity relationship diagrams are a great way to quickly visualize the structure of a Rails database & project.

In this post, we'll get up and running with the rails-erd gem which will allow us to quickly generate ERD diagrams. After that, we'll set up a rake task so that everyone on the project uses the same command to generate the diagrams. Finally, we'll show off the diagram in the readme of our Github Project!
Installing rails_erd

The rails-erd gem (github, website) analyzes models and DB schema, and uses to Graphviz to generate a diagram for us. Here's an example image from the rails-erd site:

erd-image

First, we'll simply add rails-erd to our Gemfile:
Gemfile

group :development do
  gem 'rails-erd'
end

After that, we'll need to install Graphviz. If you're using OSX and Homebrew, that's as easy as:

brew install graphviz

Then go ahead and run bundle install.
Generating a Diagram

To generate a first diagram, simply run erd. If everything is installed properly, an erd.pdf file should show up in the directory. Again, if you're on OSX you can take a look at it by running open erd.pdf.

The defaults are usually pretty nice, however, there's a lot of room for customization. You can check out the customization page for all of the available options. Note - you can also just run erd --help.

For my projects, I typically like to run something like the following:

erd --inheritance --direct --attributes=foreign_keys,content

Which will:

    Display single table inheritance models
    Only display direct relationships (does not show through relationships which can make the diagram messy).
    Display the foreign keys (nice to see what they're named)
    Display the other fields in the table

Creating a rake task

In order to ensure that everyone is using the same options when generating the diagrams, I typically make a simple rake task:
lib/tasks/erd.rake

desc 'Generate Entity Relationship Diagram'
task :generate_erd do
  system "erd --inheritance --filetype=dot --direct --attributes=foreign_keys,content"
  system "dot -Tpng erd.dot > erd.png"
  File.delete('erd.dot')
end

I've encountered issues with using Graphviz to generate filetypes other than .dot, so I'm just generating a .dot file and converting it to a .png file.
Show it off on Github!

Finally, I like to check the diagram into source control, so everyone can check it out.

We can even display the image in the Github readme! Assuming you're using markdown, you can do something like this:
README.markdown

## Domain Model
Run `rake generate_erd` to regenerate (must have graphvis).
![](/erd.png)

Which will display the image!

erd on github
