class CLI 
	attr_reader :category, :scraper 

	def call 
		@scraper = Scraper.new 
		input = nil  

		puts "\n\n\n--- Billboard Top Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---".colorize(:green)

		until input == 'exit' do
			Song.reset!
			Artist.reset!

			puts "\nMain Menu"
			puts "----------".colorize(:green)
			puts "Choose Category:"
			self.scraper.scrape_categories 
			puts "\nEnter " + "'exit'".colorize(:green) + " to quit the program"

			input = gets.strip.downcase 

			if (1..10).include?(input.to_i) 
				self.scraper.scrape_top_songs(input)
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

	def get_songs 
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

		puts "\n\n"
		puts "Enter " + "'menu'".colorize(:green) + "to return to the main menu"
		puts "Enter " + "'exit'".colorize(:green) + " to quit the program"
		input = gets.strip

		if input == 'menu' || input == 'back' || input == 'exit'
			self.handle_input(input)
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

	def get_song_details
		puts "\nEnter " + "Song Number".colorize(:green) + " For More Information\n\n"
		self.get_input 
		rank = gets.strip

		if (1..Song.all.length).include?(rank.to_i) 
			song = Song.find_by_rank(rank)
			song.details
			self.get_artist_songs(song)
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

	def get_artist_songs(song)
		puts "\nEnter " + "'Y'".colorize(:green) + " to see all songs by this Artist currently on " + "#{song.category}\n".colorize(:green)
		puts "\n\n"
		self.get_input 

		artist = gets.strip.downcase 

		if artist == 'y'
			song.artist_songs
		elsif artist == 'menu' || artist == 'back' || artist == 'exit'
			self.handle_input(artist)
		else 
			puts "Invalid Entry".colorize(:red)
			self.get_artist_songs(song)
		end 
	end 

	def handle_input(input)
		if input == 'menu'
			self.call 
		elsif input == 'back'
			self.get_songs 
		elsif input == 'exit'
			puts "Have a great day!".colorize(:red)
			exit
		end 
	end 

	def get_input 
		puts "Enter " + "'back'".colorize(:green) + " to see more songs in this category"
		puts "Enter " + "'menu'".colorize(:green) + "to return to the main menu"
		puts "Enter " + "'exit'".colorize(:green) + " to quit the program"
	end 
end