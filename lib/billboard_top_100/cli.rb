class CLI 

	def self.call 

		songs_array = Scraper.scrape_top_100("https://www.billboard.com/charts/hot-100")

		songs_list = Song.create_from_collection(songs_array)

		input = nil  

		puts "\n\n\n--- Billboard Top 100 Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---"

		until input == 'exit' 

			puts "\nMain Menu".colorize(:blue)
			puts "----------"
			puts "Enter 'songs' to choose songs"
			puts "Enter 'artists' to see all Artist in current Top 100"
			puts "Enter 'exit' to quit the program"

			input = gets.strip.downcase 


			case input 
			when 'songs'
				self.get_songs
			when 'artists'
				self.get_artists
			when 'exit'
				puts "See you next time!!!"
				input = 'exit'
			else 
				puts "Invalid Entry"
			end 
			
		end 

	end 

	def self.get_songs 

		puts "Which songs would you like to see?"

		puts "\n\nEnter '1' for The Top 10"
		puts "Enter '2' for songs 11 - 20"
		puts "Enter '3' for songs 21 - 30"
		puts "Enter '4' for songs 31 - 40"
		puts "Enter '5' for songs 41 - 50"
		puts "Enter '6' for songs 51 - 60"
		puts "Enter '7' for songs 61 - 70"
		puts "Enter '8' for songs 71 - 80"
		puts "Enter '9' for songs 81 - 90"
		puts "Enter '10' for songs 91 - 100"
		puts "Enter 'exit' to quit the program"

		input = gets.strip

		case input 
		when '1'
			Song.list_by_rank(1..10)
			self.get_song_details
		when '2'
			Song.list_by_rank(11..20)
			self.get_song_details
		when '3'
			Song.list_by_rank(21..30)
			self.get_song_details
		when '4'
			Song.list_by_rank(31..40)
			self.get_song_details
		when '5'
			Song.list_by_rank(41..50)
			self.get_song_details 
		when '6'
			Song.list_by_rank(51..60)
			self.get_song_details
		when '7'
			Song.list_by_rank(61..70)
			self.get_song_details
		when '8'
			Song.list_by_rank(71..80)
			self.get_song_details
		when '9'
			Song.list_by_rank(81..90)
			self.get_song_details
		when '10'
			Song.list_by_rank(91 ..100) 
			self.get_song_details
		when 'exit'
			puts "See you next time!!!"
			  input = 'exit'
		when 'menu'
			input = 'menu'
		else
			puts "Invalid Entry" 
			input = nil 
		end 
		
	end 

	def self.get_artists 
		Song.sort_artists_by_rank
		self.get_artist_songs
	end 

	def self.get_song_details
		rank = nil 
		until rank == 'menu' || rank == 'exit' do 
			puts "\n\n\nEnter Song Number For More Information"
			puts "Or Enter 'menu' For Main Menu"
			rank = gets.strip
			case rank
			when 'menu'
				rank = 'menu'
				input = 'menu'
			when 'exit'
				rank = 'exit'
				input = 'exit'
			else 
				Song.song_details_by_rank(rank)
			end 
		end 
	end 

	def self.get_artist_songs
		rank = nil 
		until rank == 'menu' || rank == 'exit' do 
			puts "\n\n\nEnter Artist Number to see all songs currently On the Top 100"
			puts "Or Enter 'menu' For Main Menu"
			rank = gets.strip
			case rank
			when 'menu'
				rank = 'menu'
				input = 'menu'
			when 'exit'
				rank = 'exit'
				input = 'exit'
			else 
				Song.artist_songs(rank)
			end 
		end 
	end 

end