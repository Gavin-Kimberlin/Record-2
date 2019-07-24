require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
require('./lib/song')
also_reload('lib/**/*.rb')

get ('/') do
  @albums = Album.all
  @sold = Album.all_sold
  erb(:albums)
end

get ('/albums') do
  @albums = Album.all
    @sold = Album.all_sold
  erb(:albums)
end

get ('/albums/all') do
  @albums = Album.all
  @sold = Album.all_sold
  erb(:albums)
end

get ('/albums/new') do
  erb(:new_album)
end

get ('/albums/search') do
  search_term = params[:search]
  @albums = Album.search(search_term)
  @sold = Album.all_sold
  erb(:albums)
end

get ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get ('/search') do
  erb(:search)
end

post ('/albums/:id/sold') do
  @album = Album.find(params[:id].to_i())
  @album.sold()
  erb(:purchased)
end


post ('/albums') do
  name = params[:album_name]
  year = params[:album_year]
  artist = params[:album_artist]
  genre = params[:album_genre]
  album = Album.new(name, nil, year, artist, genre)
  album.save()
  @albums = Album.all
  @sold = Album.all_sold
  erb(:albums)
end

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @album.update(params[:year])
  @album.update(params[:artist])
  @album.update(params[:genre])
  @albums = Album.all
  erb(:albums)
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  @sold = Album.all_sold
  erb(:albums)
end

get ('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end


# *********SONGS ROUTING********* #


# Get the detail for a specific song such as lyrics and songwriters.
get ('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post ('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(params[:song_name], @album.id, nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch ('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete ('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end
