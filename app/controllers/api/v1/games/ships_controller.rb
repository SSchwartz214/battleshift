class Api::V1::Games::ShipsController < ApiController
  def create
    @ship = Ship.new(params[:ship][:ship_size])
    @ship.place(params[:ship][:start_space], params[:ship][:end_space])
    @game = Game.find_by(id: params["game_id"])
    # binding.pry
  end

  def index
  end
end
