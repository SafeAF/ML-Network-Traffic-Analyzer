require 'open-uri'

BASE_URL = "https://chart.googleapis.com/chart?cht=p&chs=500x300"
rows = File.open(ARGV[0]){|f| f.readlines.map{|p| p.strip.split("\t")} }

headers = rows[0]
[1,2].each do |idx|
   labels = []
   values = []
   rows[1..-1].each do |row|
      labels << row[0]
      values << row[idx]
   end
   
   remote_google_img = URI.encode"#{BASE_URL}&chl=#{labels.join('|')}&chd=t:#{values.join(',')}"
puts remote_google_img
  File.open('file-pie-chart.png', 'w'){|f| 
    f.write(open(remote_google_img))
  }
end