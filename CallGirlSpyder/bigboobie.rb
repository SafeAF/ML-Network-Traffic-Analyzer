#!/usr/bin/env ruby
require 'fastimage'
require 'mechanize'
#require 'addressable'

$FILTERSTACK = []
$FULLSTACK = []


#class BigTitty

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
#end




module Boob

	module Media

		class Image
			def size(image); width, height = FastImage.size(image); end

			def self.size!; width, height = FastImage.size(self) ; end

		end

	end
end


# argument_parser = Com```````````````````````````mandLineArgumentParser.new
# argument_parser.parse_arguments
# spider = Spider.new
# url_store = UrlStore.new(argument_parser.url_file)
# spider.crawl_web(url_store.get_urls,
#                  argument_parser.crawl_depth,
#                  argument_parser.page_limit) if argument_parser.crawl_type== CommandLineArgumentParser::WEB_CRAWLER
# spider.crawl_domain(url_store.get_url, argument_parser.page_limit) if argument_parser.crawl_type == CommandLineArgumentParser::DOMAIN_CRAWLER
#
class UrlStack
	attr_accessor :urls, :url, :current, :count
end
module Groper

end
class BigBoobs
	attr_accessor :stack, :baseurl, :boobsbase,  :currenturl, :agent, :boobsg

	def initialize(baseurl)
		@baseurl = baseurl.to_s
		@stack = Array.new
		@boobsg = Mechanize.new
		@boobsbase = lambda {@boobsg.get('http://sublimedirectory.org')}


	end


end


def get_page(url)
 s.get(url)
end

def get_links(page)
	page.links
end

# take a page, a return a list of links that have been filtered by FOCUS array
def focus_filter_links(page)
	filtered = []
 FOCUS.each do |word|
 filter_links = page.links_with {|link| link =~ /#{word}/ }
   filtered.push(filter_links)
 end
	# put a reject in here as alternative to 2nd function?
	filtered.flatten
end

def produce_links_to_ban(page)
	filtered = []
	BANNED.each do |word|
		filter_links = page.links_with {|link| link =~ /#{word}/ }
		filtered.push(filter_links)
	end
	# put a reject in here as alternative to 2nd function?
	filtered.flatten

end

def ban_filter_links(links, banlinks)
	links - banlinks
end

page = get_page(url)
focusLinks = focus_filter_links(page)
banLinks = produce_links_to_ban(page)
filteredLinks = ban_filter_links(focusLinks, banLinks)
images = page.images



# preferred/focus links
def titty_links(links)

page.links
page.links_with {}
page.images
page.images_with {}
page.search
links = page.links
links[0].uri

page.links_with {|link| x =~ /tits/}

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