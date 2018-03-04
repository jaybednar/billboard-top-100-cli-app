class Scraper 

	def scrape_top_songs(url)

		@songs_array = []
		
		category = Nokogiri::HTML(open(url)).search("h1.chart-name span").text


		doc = Nokogiri::HTML(open(url)).search(".chart-data article.chart-row")

		doc.each do |song|
			song_hash = Hash.new 
			song_hash[:current_rank] = song.search(".chart-row__current-week").text         #=> "1"
			song_hash[:previous_rank]  = song.search(".chart-row__last-week").text.split("\n").first         #=> "Last Week: 2"
			song_hash[:song_name] =  song.search(".chart-row__song").text
			song_hash[:artist] =  song.search(".chart-row__artist").text.gsub("\n", "")
			song_hash[:weeks_on_chart] = song.search(".chart-row__weeks-on-chart span.chart-row__value").text
			song_hash[:peak_rank] = song.search(".chart-row__top-spot span.chart-row__value").text
			song_hash[:category] = category

			@songs_array << song_hash
			
		end 
		Song.create_from_collection(@songs_array) 
	end 

end 

