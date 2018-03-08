class Song
	attr_accessor :song_name, :artist, :current_rank, :previous_rank, :peak_rank, :weeks_on_chart, :category

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
	end 

	def self.find_by_hash(song_hash)
		self.all.detect{|song| song.song_name == song_hash[:song_name]}
	end 

	def self.create_by_hash(song_hash)
		song = self.new(song_hash[:song_name])
		artist_name = song_hash[:artist]
		song.artist = Artist.find_or_create_by_name(artist_name)
		song.current_rank = song_hash[:current_rank]
		song.previous_rank = song_hash[:previous_rank]
		song.peak_rank = song_hash[:peak_rank]
		song.weeks_on_chart = song_hash[:weeks_on_chart]
		song.category = song_hash[:category]
		song.artist.songs << song 
		@@all << song 
		song 
	end 

	def self.find_or_create_by_hash(song_hash)
		self.find_by_hash(song_hash) || self.create_by_hash(song_hash)
	end 

	def self.list_by_rank(range)
		puts ""
		puts "-------------------------------------------------------------------------".colorize(:green)
		songs_in_range = self.all.select{|song| range.include?(song.current_rank.to_i)}
		self.all.each.with_index(1) do |song, i|
			if songs_in_range.include?(song)
				puts "#{i}. " + "#{song.artist.name}".colorize(:red) + " - " "\"#{song.song_name}\""
			else 
			end 
		end 
		puts "-------------------------------------------------------------------------".colorize(:green)
	end 

	def self.find_by_rank(rank)
		self.all.detect{|song| song.current_rank == rank}
	end 

	def details
		puts "\n\n\n----- ##{self.current_rank} \"#{self.song_name}\" -----".colorize(:green).underline
		puts "\nArtist: #{self.artist.name}"
		puts "Rank This Week: #{self.current_rank}"
		puts "Rank #{self.previous_rank}"
		puts "Peak Rank on Chart: #{self.peak_rank}"
		puts "Weeks On Top 100: #{self.weeks_on_chart}"
		puts "\n----------------------------".colorize(:green)
	end 

	def artist_songs
		puts "\n------------------------------------------------\n".colorize(:green)
		puts "#{self.artist.name}".colorize(:green) + " has " + "#{self.artist.songs.length}".colorize(:red) + " Song(s) on " + "#{self.category}:".colorize(:green)
		self.artist.songs.each do |song|
			puts "\n\"#{song.song_name}\"".underline + ", which is currently" + " ##{song.current_rank}.".colorize(:green) 
		end 
		puts "\n------------------------------------------------\n".colorize(:green)
	end 

end 