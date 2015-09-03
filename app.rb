require("bundler/setup")
Bundler.require(:default)
require('pry')
require('active_record')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')


get("/") do
  erb(:index)
end

#############################
#######---Bands-Page---######
#############################

get('/bands') do
  @bands = Band.all()
  erb(:bands)
end

post('/bands') do
  name = params.fetch("name")
  @band = Band.create({:name => name, :done => false})
  if @band.save()
    erb(:success)
  else
    erb(:errors)
  end
end

get('/bands/:id/delete_from_bands') do
  @band = Band.find(params['id'].to_i)
  @band.destroy
  @bands = Band.all()
  erb(:bands)
end


#############################
#######---Band-Page---#######
#############################

get('/bands/:id') do
  @band = Band.find(params.fetch('id').to_i())
  if @band.venues
    @venues = @band.venues
  else
    @venue = nil
  end
  @venues = Venue.all()
  @bands = Band.all
  erb(:band)
end

post('/bands/:id/delete') do
  @band = Band.find(params['id'].to_i())
  @band.destroy
  @bands = Band.all()
  erb(:bands)
end

patch('/bands/:id/rename') do
  @band = Band.find(params['id'].to_i)
  @band.update({name: params['name']})
  @bands = Band.all()
  redirect back
end

patch('/band/:id/venue') do
  venue_id = params.fetch('venue_id').to_i()
  venue = Venue.find(venue_id)
  @band = Band.find(params.fetch('id').to_i())
  @band.venues.push(venue)
  redirect back
end

#############################
######---Venues-Page---######
#############################

get('/venues') do
  @venues = Venue.all()
  erb(:venues)
end

post('/venues') do
  title = params.fetch('title')
  @venue = Venue.create({:title => title, :done => false})
  if @venue.save()
    erb(:success)
  else
    erb(:errors)
  end
end

#############################
####---Venue-Page---#########
#############################

get('/venues/:id') do
  @venue = Venue.find(params.fetch('id').to_i())
  if @venue.bands
    @band = @venue.bands
  else
    @band = nil
  end
  @bands = Band.all()
  erb(:venue)
end

patch('/venues/:id/band') do
  band_id = params.fetch('band_id').to_i()
  band = Band.find(band_id)
  @venue = Venue.find(params.fetch('id').to_i())
  @venue.bands.push(band)
  redirect back
end
