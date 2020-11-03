require 'pry'

class Artist
  
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
    name = Artist.new(name)
    name.save
    name
  end
  
  def songs
    @songs
  end
  
  def add_song(new_song)
    songs.include?(new_song) || songs << new_song
    new_song.artist = self if new_song.artist.nil? 
  end
  
  def genres
    songs.map{|song| song.genre}.uniq
  end
    
end 