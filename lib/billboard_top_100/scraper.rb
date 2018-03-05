class Scraper 
	@@categories = ["hot-100", "pop-songs", "country-songs", "rock-songs", "r-b-hip-hop-songs", "dance-electronic-songs", "latin-songs", "christian-songs", "hot-holiday-songs", "greatest-hot-100-singles"]

	def scrape_categories
		@@categories.each.with_index(1) do |slug, i|
			if slug == "r-b-hip-hop-songs" 
				category = "R&B/HIP-HOP SONGS"
			else 
				category = slug.gsub("-", " ").upcase
			end 
			if (1..9).include?(i)
				puts "#{i}. ".colorize(:green) + " #{category}"
			else 
				puts "#{i}. ".colorize(:green) + "#{category}"
			end 

		end 
	end 

	def scrape_top_songs(input)
		cat_index = input.to_i - 1

		@songs_array = []
	
		doc = Nokogiri::HTML(open("https://www.billboard.com/charts/#{@@categories[cat_index]}")).search(".chart-data article.chart-row")

		doc.each do |song|

			song_hash = Hash.new 
			song_hash[:current_rank] = song.search(".chart-row__current-week").text         #=> "1"
			song_hash[:previous_rank]  = song.search(".chart-row__last-week").text.split("\n").first         #=> "Last Week: 2"
			song_hash[:song_name] =  song.search(".chart-row__song").text
			song_hash[:artist] =  song.search(".chart-row__artist").text.gsub("\n", "")
			song_hash[:weeks_on_chart] = song.search(".chart-row__weeks-on-chart span.chart-row__value").text
			song_hash[:peak_rank] = song.search(".chart-row__top-spot span.chart-row__value").text
			if @@categories[cat_index] == "r-b-hip-hop-songs" 
				song_hash[:category] = "R&B/HIP-HOP SONGS"
			else
				song_hash[:category] = @@categories[cat_index].gsub("-", " ").upcase
			end 
			
			@songs_array << song_hash
		end 
		Song.create_from_collection(@songs_array) 
	end 

end 

