Items in here are available in every view. put partials here



Global Partials

Sometimes you may want to make a partial accessible from anywhere. While you can easily reference the path of a partial (For example, layouts/html_header it can often be much easier to just make the partial global. To do this, create a new folder inside your views folder called application. Any partial you add to this folder can be referenced from anywhere. The previous example has been modified below to illustrate this feature.
app/views/application/_html_header.html.erb:

<head>
  <title>PartialsExample</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>

app/views/layouts/application.html.erb:

<!DOCTYPE html>
<html>
<%= render 'html_header' %>
<body>

<%= yield %>

</body>
</html>

Variables in Partials

You can also pass variables to your partials. To do this you simply append the name of the variable and it's value to the render method. An example of this is listed below.
app/views/layouts/application.html.erb:

<!DOCTYPE html>
<html>
<%= render 'html_header', title: "Example App" %>
<body>

<%= yield %>

</body>
</html>

app/views/application/_html_header.html.erb:

<head>
  <title><%= title %></title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
