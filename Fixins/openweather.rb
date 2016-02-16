require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'rest-client'

get '/' do
  api_result = RestClient.get 'http://api.openweathermap.org/data/2.5/weather?id=5110629&units=imperial'
  jhash = JSON.parse(api_result)
  output = ''

  jhash['main'].each do |w|
    title_tag = w[0]
  info_item = w[1]
    output << "<tr><td>#{title_tag}</td><td>#{info_item}</td></tr>"
end

  erb :index, :locals => {results: output}
end

## Index.html.erb
__END__
<table>
  <th>The Weather in Buffalo, NY, USA</th>
  <tr>
    <td><%= results %></td>
  </tr>
</table>

<hr noshade>

Powered by the <a href = 'http://openweathermap.org/' target = _new>Open Weather Map API</a>