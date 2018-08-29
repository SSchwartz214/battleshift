class Api::V1::Games::ShipsController < ApiController
  def create
    @ship = Ship.new(params[:ship][:ship_size])
    @ship.place_ships(params[:ship][:start_space], params[:ship][:end_space])
  end

  def index
  end
end
