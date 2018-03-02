class CLI 

	def self.call 

		songs_array = Scraper.scrape_top_100("https://www.billboard.com/charts/hot-100")

		songs_list = Song.create_from_collection(songs_array)

		input = nil 

		puts "\n\n\n--- Billboard Top 100 Songs As Of #{Time.now.month}/#{Time.now.day}/#{Time.now.year} ---"

		until input == 'exit' 

			puts "\nMain Menu"
			puts "----------"
			puts "Enter 'Songs' to choose songs"
			puts "Enter 'Artists' to see all Artist in current Top 100"
			puts "Enter 'exit' to quit the program"

			
		end 

	end 

	def self.get_songs 
		puts "Which songs would you like to see?"

		puts "\n\nEnter 'Top 10' for The Top 10"
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
		when 'Top 10'
			Song.list_by_rank(1..10)
			rank = nil 
			while rank != 'menu' do 
				self.get_details
			end 
		when '2'
			Song.list_by_rank(11..20)
		when '3'
			Song.list_by_rank(21..30)
		when '4'
			Song.list_by_rank(31..40)
		when '5'
			Song.list_by_rank(41..50) 
		when '6'
			Song.list_by_rank(51..60)
		when '7'
			Song.list_by_rank(61..70)
		when '8'
			Song.list_by_rank(71..80)
		when '9'
			Song.list_by_rank(81..90)
		when '10'
			Song.list_by_rank(91 ..100) 
		when 'exit'
			puts "See you next time!!!"
			  input == 'exit'
		else
			puts "Invalid Entry" 
			input = nil 
		end 
	end 

	def self.get_artists 

	end 

	def self.get_details
		puts "Enter Song Number For More Information Or 'menu' For Main Menu"
		rank = gets.strip
		Song.song_details_by_rank(rank)
	end 


end