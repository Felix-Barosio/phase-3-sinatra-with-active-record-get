class ApplicationController < Sinatra::Base

  #to set the Content-Type headers for all response
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # Get all games from the database
    game = Game.all.order(:title).limit(10)
    # Return a JSON response with the array of all games data
    game.to_json
  end

  # get '/games/:id' do
  #   # lookup game from the database
  #   game = Game.find(params[:id])
  #   # Return a JSON response with the array of the game data
  #   game.to_json(include: {reviews: {include: :user}})
  # end

  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end


end
