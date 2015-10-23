#!/usr/bin/env ruby
#                                            cvvcc
$:.unshift File.join(File.dirname(__FILE__))
## RENAME TO BIGBOOBS CRAWLER
require 'mechanize'
require 'fastimage'
require 'openssl'
require 'net/htt[id v\\\vir C
'n
[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
# FastImage

 # FastImage.size #.type
# require 'benchmark'
# 2: n = 50000
# 3: Benchmark.bm do |x|
# 	4:   x.report { for i in 1..n; a = "1"; end }
# 	5:   x.report { n.times do   ; a = "1"; end }
# 	6:   x.report { 1.upto(n) do ; a = "1"; end }
# 	7: end
#
# and benchmark.realtime

### make web interface wiht search box put multiple terms in comma seperated


# ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
# ActiveRecord::Base.establish_connection('development')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: '10.0.1.17', port: '6379', db: 4})}

## Note 86400 is 60days
$SHM = Redis::List.new('crawler:boobs', :marshal => true) #, :expiration => 86400)

$TITLE = 'BigBoobs Crawler'


argument_parser = CommandLineArgumentParser.new
argument_parser.parse_arguments
spider = Spider.new
url_store = UrlStore.new(argument_parser.url_file)
spider.crawl_web(url_store.get_urls,
                 argument_parser.crawl_depth,
                 argument_parser.page_limit) if argument_parser.crawl_type== CommandLineArgumentParser::WEB_CRAWLER
spider.crawl_domain(url_store.get_url, argument_parser.page_limit) if argument_parser.crawl_type == CommandLineArgumentParser::DOMAIN_CRAWLER




module Media
def image_size(image)
	 width, height = FastImage.size(image)


end
end


module BigTitty

  alias_method(paused?, is_paused/vvvvvvvvvvvvvvvvvv)
	# motorboat is for functions controlling the groper
	module MotorBoat
		  def continue!(&block)
				@paused = false
				return run(&block)
		  end

		def pause=(state)
			@paused = state
		end

		  def pause!
			  @paused= true
d				raise(Paused)
		  end

		def is_paused?
			@paused == true
		end

		def skip_link!
		raise SkipLink
		end


		  def skip_page!
			  raise SkipPage
		  end


		  ## Doubtful this should be protected, probably private instead
		  protected

		def init_actions(opt={})
			@paused = false
		end


		  ## Base Exception Class
		class TittyError < RuntimeError

		end

		  ## Using exceptions for flow control is a no no!
		  ## Lets try using lazy eval or maybe eventmachine/eventdriven arch
		class Paused < TittyError

		end

		class SkipLink < TittyError

		end

		class SkipPage < TittyError

		end

	end


	class Groper
		attr_accessor :url, :uri, :baseurl, :stack, :store, :pash

		def initialize(baseurl)
			@baseurl = baseurl
		end


		def crawl
			@url = 'http://sublimedirectory.com'
			@agent = Mechanize.new
			@page = @agent.get(@url)
			@stackin = @page.links # links_with %r regex
			p @stackin

		end

		def crawl_domain(url, page_limit = 100)
			return if @already_visited.size == page_limit
			url_object = open_url(url)
			return if url_object == nil
			parsed_url = parse_url(url_object)
			return if parsed_url == nil
			@already_visited[url]=true if @already_visited[url] == nil
			page_urls = find_urls_on_page(parsed_url, url)
			page_urls.each do |page_url|
				if urls_on_same_domain?(url, page_url) and @already_visited[page_url] == nil
					crawl_domain(page_url)
				end
			end
		end

		def crawl_web(urls, depth=2, page_limit = 100)
			depth.times do
				next_urls = []
				urls.each do |url|
					url_object = open_url(url)
					next if url_object == nil
					url = update_url_if_redirected(url, url_object)
					parsed_url = parse_url(url_object)
					next if parsed_url == nil
					@already_visited[url]=true if @already_visited[url] == nil
					return if @already_visited.size == page_limit
					next_urls += (find_urls_on_page(parsed_url, url)-@already_visited.keys)
					next_urls.uniq!
				end
				urls = next_urls
			end
		end


	end
end



boobies = BigTitty.new








class BigTitty

	# Use grok pure to match on these and extend or fuzzy match

FOCUS = %w[tits bigtits hugetits boobs bigboobs niceboobs nice latina fuck
sex titties ass girls hot sexy women babes bangbros gf]
FOCUS.push "big tits", "huge tits", "nice tits", "big boobs", "huge boobs"
FOCUS.push "latina big tits", "nice latina tits", "sexy latina", "milf"
FOCUS.push "milf latina", "milf video", "milf porn", "latina video"
FOCUS.push "latina porn", "latina milf", "latin big tits", "latina fucked"
BANNED = %w[hairy gay trans transexual fag homo cock cocks penis guys men
child children kids kid wierd tranny suprise fetish bdsm pain hurt boys boy
squirt dick dicks bondage torture maim injure ugly fugly butterface]
end


	__END__


def method_missing(name, *args)
	return get_attribute(name) if args.length == 0

	set_attribute(name, *args)
end

def [](key)
	@data[key]
end

def []=(key, value)
	@data[key] = value
end

def each(&block)
	@data.each do |key, value|
		block.call(key, value)
	end
end

def attribute?(name)
	@data.has_key?(name)
end

def set(name, *value)
	set_attribute(name, *value)
end
