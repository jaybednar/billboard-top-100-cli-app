class Scraper 
	

	def scrape_categories
		["hot-100",
		"pop-songs",
		"country-songs",
		"rock-songs",
		"r-b-hip-hop-songs",
		"dance-electronic-songs",
		"latin-songs",
		"christian-songs",
		"hot-holiday-songs",
		"greatest-hot-100-singles"].each.with_index(1) do |slug, i|
			category = slug.gsub("-", " ").upcase
			# if (slug == "https://www.billboard.com/charts/hot-100" || slug == "https://www.billboard.com/charts/dance-electronic-songs" || slug == "https://www.billboard.com/charts/greatest-hot-100-singles")
			# 	category = Nokogiri::HTML(open(slug)).search("img.chart-name-image-main").attr("alt").value 
			# else 
			# 	category = Nokogiri::HTML(open(slug)).search("h1.chart-name span").text
			# end 

			puts "#{i}. ".colorize(:green) + "#{category}"
		end 

	end 

	def scrape_top_songs(slug)

		@songs_array = []
		
		# category = Nokogiri::HTML(open(slug)).search("h1.chart-name span").text

		# category = Nokogiri::HTML(open(slug)).search("div.chart-header-headline h1.chart-name img.chart-name-image-main").attr("alt").value 

		doc = Nokogiri::HTML(open("https://www.billboard.com/charts/#{slug}")).search(".chart-data article.chart-row")

		doc.each do |song|

			song_hash = Hash.new 
			song_hash[:current_rank] = song.search(".chart-row__current-week").text         #=> "1"
			song_hash[:previous_rank]  = song.search(".chart-row__last-week").text.split("\n").first         #=> "Last Week: 2"
			song_hash[:song_name] =  song.search(".chart-row__song").text
			song_hash[:artist] =  song.search(".chart-row__artist").text.gsub("\n", "")
			song_hash[:weeks_on_chart] = song.search(".chart-row__weeks-on-chart span.chart-row__value").text
			song_hash[:peak_rank] = song.search(".chart-row__top-spot span.chart-row__value").text
			song_hash[:category] = slug.gsub("-", " ").upcase
			# binding.pry
			# if (slug == "https://www.billboard.com/charts/hot-100" || slug == "https://www.billboard.com/charts/dance-electronic-songs" || slug == "https://www.billboard.com/charts/greatest-hot-100-singles")
			# 	song_hash[:category] = Nokogiri::HTML(open(slug)).search("img.chart-name-image-main").attr("alt").value 
			# else 
			# 	song_hash[:category] = Nokogiri::HTML(open(slug)).search("h1.chart-name span").text
			# end 

			@songs_array << song_hash
		end 
		Song.create_from_collection(@songs_array) 
	end 

end 

