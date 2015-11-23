require 'google-rest'

google = GoogleSearch.new
arr_of_arrs.map do |row|
  begin
    result = google.search(:q => "#{row[0]} ruby gem")[0]
    puts "<div style=\"margin-top:10px\">
		#{row[0]}</div>
		<div style=\"margin-top:5px\"><a href=\"#{result.url}\" >#{result.content}</a></div>"
  rescue SyntaxError => error
  rescue => exc
  end
end