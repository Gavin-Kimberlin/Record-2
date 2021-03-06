require './lib/song'

class Album
  attr_accessor :id, :name, :year, :genre, :artist

  @@albums = {}
  @@sold = {}
  @@total_rows = 0

  def initialize(name, id, year, artist, genre)
    @name = name
    @id = id || @@total_rows += 1
    @year = year
    @artist = artist
    @genre = genre
  end

  def self.all
    @@albums.values()
  end

  def self.all_sold
    @@sold.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.artist, self.genre)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name, id, year, artist, genre)
     self.name = name
     self.id = id
     self.year = year
     self.artist = artist
     self.genre = genre
     @@albums[self.id] = Album.new(self.name, self.id, self.year, self.artist, self.genre)
  end

  def delete
    @@albums.delete(self.id)
  end

  def self.search(search_term)
    @@albums.select{|key, value| value.name =~/#{search_term}/}.values
  end

  def sold
   @@sold[self.id] = Album.new(self.name, self.id, self.year, self.artist, self.genre)
   @@albums.delete(self.id)
  end
# THIS IS NOT CONNECTED TO ANYTHING NEED TO FIGURE THIS OUT
  def self.sort(sort_method = :name)
    @@albums.sort_by{|key, album| album.send(sort_method) }
    # ablumnsa  = {1 => Alumb{NAME: FOO, ID: 1 }}
    # https://ruby-doc.org/core-2.6.3/Object.html?#method-i-send
    # https://ruby-doc.org/core-2.6.3/Enumerable.html?#method-i-sort_by
    # http://www.rubyinside.com/how-to/ruby-sort-hash?
  end
  def songs
   Song.find_by_album(self.id)
 end
end
