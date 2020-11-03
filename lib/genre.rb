class Genre
  
  # include Memorable::InstanceMethods 
  extend Concerns::Findable
  
  @@all = []
  
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    name = Genre.new(name)
    name.save
    name
  end
  
  def songs
    @songs
  end
  
  def add_genre(new_song)
    songs.include?(new_song) || songs << new_song 
    new_song.genre = self if new_song.genre.nil?
  end
  
  def artists
    @songs.map{|song| song.artist}.uniq
  end
  
end 