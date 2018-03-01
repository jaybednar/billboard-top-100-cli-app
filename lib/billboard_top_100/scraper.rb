class Scraper 


	def self.scrape_top_100(url)

		@all = []

		doc = Nokogiri::HTML(open(url)).search(".chart-data article.chart-row")

		doc.each do |song|
			song_hash = Hash.new 
			song_hash[:current_rank] = song.search(".chart-row__current-week").text         #=> "1"
			song_hash[:previous_rank]  = song.search(".chart-row__last-week").text          #=> "Last Week: 2"
			song_hash[:song] =  song.search(".chart-row__song").text
			song_hash[:artist] =  song.search(".chart-row__artist").text.gsub("\n", "")
			song_hash[:weeks_on_chart] = song.search(".chart-row__weeks-on-chart span.chart-row__value").text
			song_hash[:peak_spot] = song.search(".chart-row__top-spot span.chart-row__value").text
			@all << song_hash
			
		end 
	end 
end 

