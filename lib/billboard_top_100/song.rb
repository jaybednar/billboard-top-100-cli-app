class Song
	attr_accessor :song_name, :artist, :current_rank, :previous_rank, :peak_rank, :weeks_on_chart

	@@all = []

	def self.all 
		@@all 
	end 

	def self.reset!
		self.all.clear
	end 

	def initialize(song_name)
		@song_name = song_name 
	end 

	def self.create_from_collection(songs_array)
		songs_array.each do |song_hash|
			self.find_or_create_by_hash(song_hash)
		end 
		# binding.pry
	end 

	def self.find_by_hash(song_hash)
		self.all.detect{|song| song.song_name == song_hash[:name]}
	end 

	def self.create_by_hash(song_hash)
		song = self.new(song_hash[:song_name])
		artist_name = song_hash[:artist]
		song.artist = Artist.find_or_create_by_name(artist_name)
		song.current_rank = song_hash[:current_rank]
		song.previous_rank = song_hash[:previous_rank]
		song.peak_rank = song_hash[:peak_rank]
		song.weeks_on_chart = song_hash[:weeks_on_chart]
		# binding.pry
		song.artist.songs << song 
		@@all << song 
		song 
	end 

	def self.find_or_create_by_hash(song_hash)
		self.find_by_hash(song_hash) || self.create_by_hash(song_hash)
	end 

	def self.sort_artists_by_rank 
		sorted_list = self.all.sort do |song_1, song_2|
			song_1.current_rank.to_i <=> song_2.current_rank.to_i
		end 
		sorted_list.each.with_index(1) do |song, i|
			puts "#{i}. #{song.artist.name}"
		end 
	end 

	def self.list_by_rank(range)
		puts ""
		puts "------------------------------------------------".colorize(:green)
		songs_in_range = self.all.select{|song| range.include?(song.current_rank.to_i)}
		self.all.each.with_index(1) do |song, i|
			if songs_in_range.include?(song)
				puts "#{i}. " + "#{song.artist.name}".colorize(:red) + " - " "\"#{song.song_name}\""
			else 
			end 
		end 
		puts "------------------------------------------------".colorize(:green)
	end 

	def self.find_by_rank(rank)
		self.all.detect{|song| song.current_rank == rank}
	end 

	def self.song_details_by_rank(rank)
		song = self.find_by_rank(rank)
		puts "\n\n\n--- ##{song.current_rank} \"#{song.song_name}\" ---".colorize(:green)
		puts "\nArtist: #{song.artist.name}"
		puts "Rank This Week: #{song.current_rank}"
		puts "Rank #{song.previous_rank}"
		puts "Peak Rank on Chart: #{song.peak_rank}"
		puts "Weeks On Top 100: #{song.weeks_on_chart}"
		puts "\n----------------------------".colorize(:green)
		song
	end 

	def self.artist_songs(rank)
		song = self.find_by_rank(rank)
		puts "\n#{song.artist.name}".colorize(:green) + " has " + "#{song.artist.songs.length}".colorize(:red) + " Song(s) in the " + "#{CLI.category}:".colorize(:green)
		song.artist.songs.each do |song|
			puts "\n\"#{song.song_name}\"".underline + ", which is currently" + " ##{song.current_rank}.".colorize(:green) 
		end 
		puts "\n----------------------------\n".colorize(:green)
	end 

end 