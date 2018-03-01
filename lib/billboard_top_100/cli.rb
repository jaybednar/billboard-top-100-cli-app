class CLI 

	def self.call 

		songs_array = Scraper.scrape_top_100("https://www.billboard.com/charts/hot-100")

		Song.create_from_collection(songs_array)

		binding.pry

		

		input = nil 

		puts "--- Billboard Top 100 Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---"

		until input == 'exit' 

			puts %{Which songs would you like to see? 
				Enter '1' for The Top 10 
				Enter '2' for songs 10 - 20 
				Enter '3' for songs 20 - 30 
				Enter '4' for songs 30 - 40 
				Enter '5' for songs 40 - 50 
				Enter '6' for songs 50 - 60 
				Enter '7' for songs 60 - 70 
				Enter '8' for songs 70 - 80 
				Enter '9' for songs 80 - 90 
				Enter '10' for songs 90 - 100
				Enter 'exit' to quit the program}

			input = gets.strip

			if input == '1'
				puts '1'
			elsif input == '2'
				puts '2'
			elsif input == '3'
				puts '3'
			elsif input == '4'
				puts '4'
			elsif input == '5'
				puts '5'
			elsif input == '6'
				puts '6'
			elsif input == '7'
				puts '7'
			elsif input == '8'
				puts '8'
			elsif input == '9'
				puts '9'
			elsif input == '10'
				puts '10'
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