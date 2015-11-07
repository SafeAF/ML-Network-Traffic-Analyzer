# Searching Active Record


	

Use a query that searches a substring in between:

name = "Manhattan"
Movie.where("title like ?", "%#{name}%")
Copy

For example:

    %Manhattan will get you: Love in Manhattan
    Manhattan% will get: Manhattan and Company
    %Manhattan% will get you both: [Love in Manhattan, Manhattan and Company]


But, if you're searching through movies synopsis, you should use Thinking Sphinx or Elastic Search

For example, with Elastic Search, you could set the synopsis like this:

Add app/indices/movie_index.rb:

ThinkingSphinx::Index.define :movie, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes synopsis
end
Copy

Index your data with rake ts:index

And then run Sphynx with: rake ts:start

You can search just like this:

Movie.search :conditions => {:synopsis => "Manhattan"}