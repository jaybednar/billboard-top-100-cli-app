class Scraper 


	def self.scrape_top_100(url)
		doc = Nokogiri::HTML(open(url))

		#current_rank = doc.search(".chart-row__current-week").text         #=> "1"
		#previous_rank  = doc.search(".chart-row__last-week").text          #=> "Last Week: 2"
		#song =  doc.search(".chart-row__song").text
		#artist =  doc.search(".chart-row__artist").text.gsub("\n", "")
		#weeks_on_chart = doc.search(".chart-row__weeks-on-chart span.chart-row__value").text
		#peak_spot = doc.search(".chart-row__top-spot span.chart-row__value").text
		binding.pry
	end 
end 

