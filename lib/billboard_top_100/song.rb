class Song
	attr_accessor :name, :artist, :current_rank, :previous_rank, :peak_rank, :weeks_on_chart

	@@all = []

	def self.all 
		@@all 
	end 

	def initialize(name)

	end 

	def self.create_from_collection(songs_array)
		songs_array.each do |song_hash|
			self.find_or_create_by_hash(song_hash)
		end 
		# binding.pry
	end 

	def self.find_by_hash(song_hash)
		self.all.detect{|song| song.name == song_hash[:name]}
	end 

	def self.create_by_hash(song_hash)
		song = self.new(song_hash[:name])
		song.artist = Artist.find_or_create_by_name(song_hash[:artist])
		song.current_rank = song_hash[:current_rank]
		song.previous_rank = song_hash[:previous_rank]
		song.peak_rank = song_hash[:peak_rank]
		song.weeks_on_chart = song_hash[:weeks_on_chart]

		song.artist.songs << song 
		@@all << song 
		song 
	end 

	def self.find_or_create_by_hash(song_hash)
		self.find_by_hash(song_hash) || self.create_by_hash(song_hash)
	end 

end 