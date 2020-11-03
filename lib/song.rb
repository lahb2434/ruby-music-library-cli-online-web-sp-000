require 'pry'

class Song
  
  # include Memorable::InstanceMethods 
  # extend Memorable::ClassMethods
  extend Concerns::Findable
  
  @@all = []
  
  attr_accessor :name, :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist.nil? 
    self.genre=(genre) unless genre.nil?
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
    name = Song.new(name)
    name.save
    name
  end
  
  def artist= (artist)
    @artist = artist
    artist.add_song(self)
  end
 
  def genre= (genre)
   @genre = genre
    genre.add_genre(self)
  end
 
  # def self.find_by_name(name)
  #   self.all.detect{|song| song.name == name}
  # end
 
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name) || self.create(name)
  # end
  
  def self.new_from_filename(filename)
    file = filename.gsub('.',' - ').split(' - ')
    song = self.find_or_create_by_name(file[1])
    artist = Artist.find_or_create_by_name(file[0])
    genre = Genre.find_or_create_by_name(file[2])
    song.artist=(artist)
    song.genre=(genre)
    song
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
  
  

end 