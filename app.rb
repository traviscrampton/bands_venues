require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

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
  Band.create({:name => name})
  redirect("/bands")
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

#############################
######---Venues-Page---######
#############################

get('/venues') do
  @venues = Venue.all()
  erb(:venues)
end

post('/venues') do
  title = params.fetch('title')
  Venue.create({:title => title})
  redirect('/venues')
end
