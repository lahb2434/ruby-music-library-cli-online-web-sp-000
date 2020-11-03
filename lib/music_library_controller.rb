require 'pry'

class MusicLibraryController
  
  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end
  
  def call
    user_input = nil 
    until user_input == 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      case user_input = gets.strip
        when 'list songs'
          list_songs
        when 'list artists'
          list_artists
        when 'list genres'
          list_genres
        when 'list artist'
          list_songs_by_artist
        when 'list genre'
          list_songs_by_genre
        when 'play song'
          play_song
        end
    end
  end
  
  def list_songs
    Song.all.sort_by{|song| song.name}.map.with_index(1) do |song, index| 
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists 
    Artist.all.sort_by{|artist| artist.name}.each.with_index(1) do |artist, index| 
      puts "#{index}. #{artist.name}"
    end
 end
 
 def list_genres 
    Genre.all.sort_by{|genre| genre.name}.each.with_index(1) do |genre, index| 
      puts "#{index}. #{genre.name}"
    end
 end
 
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
      if artist = Artist.find_by_name(input)
      artist.songs.sort_by{|song| song.name}.map.with_index(1) do |song, index| 
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
   def list_songs_by_genre
     puts "Please enter the name of a genre:"
     input = gets.strip
       if genre = Genre.find_by_name(input)
       genre.songs.sort_by{|song| song.name}.map.with_index(1) do |song, index| 
         puts "#{index}. #{song.artist.name} - #{song.name}"
       end     
      end
  end
  
  # def list_songs_by_genre
  #   puts "Please enter the name of a genre:"
  #   Song.all.select{|song| song.genre.name == gets.strip}.sort_by(&:name).map.with_index(1){|song, index| puts "#{index}. #{song.artist.name} - #{song.name}"}
  # end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    list = Song.all.sort_by{|song| song.name}
    if input.between?(1, list.length)
      puts "Playing #{list[input-1].name} by #{list[input-1].artist.name}"
    end
    
  end
      
  
end 