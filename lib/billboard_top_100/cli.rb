class CLI 

	def self.call 

		songs_array = Scraper.scrape_top_100("https://www.billboard.com/charts/hot-100")

		songs_list = Song.create_from_collection(songs_array)

		input = nil 

		puts "--- Billboard Top 100 Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---"

		until input == 'exit' 

			puts %{Which songs would you like to see? 
				Enter 'Top 10' for The Top 10 
				Enter '2' for songs 11 - 20 
				Enter '3' for songs 21 - 30 
				Enter '4' for songs 31 - 40 
				Enter '5' for songs 41 - 50 
				Enter '6' for songs 51 - 60 
				Enter '7' for songs 61 - 70 
				Enter '8' for songs 71 - 80 
				Enter '9' for songs 81 - 90 
				Enter '10' for songs 91 - 100
				Enter 'exit' to quit the program}

			input = gets.strip

			if input == 'Top 10'
				Song.list_by_rank(1..10)
			elsif input == '2'
				Song.list_by_rank(11..20)
			elsif input == '3'
				Song.list_by_rank(21..30)
			elsif input == '4'
				Song.list_by_rank(31..40)
			elsif input == '5'
				Song.list_by_rank(41..50) 
			elsif input == '6'
				Song.list_by_rank(51..60)
			elsif input == '7'
				Song.list_by_rank(61..70)
			elsif input == '8'
				Song.list_by_rank(71..80)
			elsif input == '9'
				Song.list_by_rank(81..90)
			elsif input == '10'
				Song.list_by_rank(91 ..100) 
			elsif input == 'exit'
				puts "See you next time!!!"
				  input == 'exit'
			else
				puts "Invalid Entry" 
				input = nil 
			end 
		end 

	end 
end