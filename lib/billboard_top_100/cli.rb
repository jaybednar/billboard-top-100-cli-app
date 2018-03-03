class CLI 
	attr_reader :category

	def self.call 

		input = nil  

		puts "\n\n\n--- Billboard Top Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---"

		until input == 'exit' do
			Song.reset!
			Artist.reset!

			songs_array = nil
		    songs_list = nil 

			puts "\nMain Menu"
			puts "----------".colorize(:green)
			puts "Choose Category:"
			puts "\n1. Billboard Hot 100"
			puts "2. Mainstream Top 40"
			puts "3. Today's Top Country"
			puts "4. Today's Top Rock"
			puts "5. Today's Top R&B/Hip-Hop"
			puts "6. Today's Top Dance/Electronic"
			puts "7. Today's Top Latin"
			puts "8. Today's Top Christian/Gospel"
			puts "9. Greatest Holiday Top 100"
			puts "10. Greatest All Time Hot 100"
			puts "\nEnter 'exit' to quit the program"

			input = gets.strip.downcase 

			if (1..10).include?(input.to_i) 
				self.set(input)
				self.get_songs 
			elsif input != 'exit' 
				puts "Invalid Entry".colorize(:red)
				self.call 
			else 
				puts "Have a great day!".colorize(:red)
				exit
			end 
		end 

	end 

	def self.get_songs 
		input = nil 

		num = (1..Song.all.length).to_a

		puts "\n\nWhich songs would you like to see?"
		puts "-----------------------------------\n".colorize(:green)
		i = 0
		entry = 1
		while i < Song.all.length do 
		  puts "Enter " + "'#{entry}'".colorize(:green) + " for songs #{num[i, 10].first} - #{num[i, 10].last}"
		  i += 10 
		  entry += 1 
		end 

		input = gets.strip

		if input == 'menu'
			self.call 
		elsif input.to_i >= entry || input.to_i == 0  
			puts "Invalid Entry"
			self.get_songs 
		else 
			range_end = input.to_i * 10 - 1
			range_start = range_end - 9
			rank_range = (num[range_start]..num[range_end])
			Song.list_by_rank(rank_range)
			self.get_song_details
		end 
	
	end 

	def self.get_song_details
		puts "\nEnter " + "Song Number".colorize(:green) + " For More Information"
		self.get_input 
		rank = gets.strip

		if (1..Song.all.length).include?(rank.to_i) 
			song = Song.song_details_by_rank(rank)
			Song.artist_songs(song.current_rank)
		elsif rank == 'menu' || rank == 'back' || rank == 'exit'
			self.handle_input(rank)
		else 
			puts "Invalid Entry".colorize(:red)
			self.get_song_details
		end 

		self.get_input 
		input = gets.strip 
		
		if input == 'menu' || input == 'back' || input == 'exit'
			self.handle_input(input)
		else 
			puts "Invalid Entry".colorize(:red)
			self.get_song_details
		end 
	end 

	# def self.get_artist_songs(song)
	# 	puts "\n\n\nEnter " + "'Y'".colorize(:green) + " to see all songs by this Artist currently on this list"
	# 	puts "Or Enter " + "'menu'".colorize(:green) + " For Main Menu\n"
	# 	puts "Enter " + "'exit'".colorize(:green) + " to quit the program"
	# 	artist = gets.strip.upcase
	# 	if artist == 'Y'
	# 		Song.artist_songs(song.current_rank)
	# 	elsif artist == 'menu'
	# 		input = 'menu'
	# 	elsif artist == 'exit'
	# 		puts "Have a great day!".colorize(:red)
	# 		exit
	# 	else 
	# 		puts "Invalid Entry".colorize(:red)
	# 		self.get_artist_songs(song)
	# 	end 
	# end 

	def self.current_category(category)
		@category = category
	end 

	def self.category 
		@category
	end 

	def self.set(input)
		case input 
		when '1'
			self.current_category("Billboard Hot 100")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/hot-100")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '2'
			self.current_category("Mainstream Top 40")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/pop-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '3'
			self.current_category("Today's Top Country")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/country-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
			# binding.pry
		when '4'
			self.current_category("Today's Top Rock")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/rock-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '5'
			self.current_category("Today's Top R&B/Hip-Hop")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/r-b-hip-hop-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '6'
			self.current_category("Today's Top Dance/Electronic")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/dance-electronic-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '7'
			self.current_category("Today's Top Latin")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/latin-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '8'
			self.current_category("Today's Top Christian/Gospel")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/christian-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '9'
			self.current_category("Greatest Holiday Top 100")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/hot-holiday-songs")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when '10'
			self.current_category("Greatest All Time Hot 100")
			songs_array = Scraper.scrape_top_songs("https://www.billboard.com/charts/greatest-hot-100-singles")
			songs_list = Song.create_from_collection(songs_array)
			# self.get_songs
		when 'exit'
			puts "See you next time!!!"
			input = 'exit'
		else 
			puts "Invalid Entry".colorize(:red)
		end 
	end 

	def self.handle_input(input)
		if input == 'menu'
			self.call 
		elsif input == 'back'
			self.get_songs 
		elsif input == 'exit'
			puts "Have a great day!".colorize(:red)
			exit
		end 
	end 

	def self.get_input 
		puts "Enter " + "'back'".colorize(:green) + " to see more songs in this category"
		puts "Enter " + "'menu'".colorize(:green) + "to return to the main menu"
		puts "Enter " + "'exit'".colorize(:green) + " to quit the program"
	end 
end