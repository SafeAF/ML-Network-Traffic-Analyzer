#!/usr/bin/env ruby
FastImage

FastImage.size #.type


module Boob

	module Media

		class Image
			def size(image); width, height = FastImage.size(image); end

			def self.size!; width, height = FastImage.size(self) ; end

		end

	end
end


argument_parser = CommandLineArgumentParser.new
argument_parser.parse_arguments
spider = Spider.new
url_store = UrlStore.new(argument_parser.url_file)
spider.crawl_web(url_store.get_urls,
                 argument_parser.crawl_depth,
                 argument_parser.page_limit) if argument_parser.crawl_type== CommandLineArgumentParser::WEB_CRAWLER
spider.crawl_domain(url_store.get_url, argument_parser.page_limit) if argument_parser.crawl_type == CommandLineArgumentParser::DOMAIN_CRAWLER



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