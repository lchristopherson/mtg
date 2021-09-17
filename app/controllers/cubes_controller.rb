class CubesController < ApplicationController
  before_action :set_cube, only: [:show, :update, :destroy]

  # GET /cubes
  def index
    @cubes = Cube.all

    render json: @cubes
  end

  # GET /cubes/1
  def show
    render json: @cube
  end

  # POST /cubes
  def create
    @cube = Cube.create(name: cube_params[:name])

    downcase = cube_params[:cards].map(&:downcase)
    all_cards = downcase.to_set

    found = Card.where(name: downcase)
    missing = all_cards ^ found.map(&:name).to_set

    puts "missing the following cards:\n#{missing}"

    cards = SetLoader.new.load_list(missing)

    # create cards if necessary
    created = cards.map do |card|
      Card.create(card)
    end

    @cube.cards += found
    @cube.cards += created

    render status: :ok
  end

  # DELETE /cubes/1
  def destroy
    @cube.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cube
      @cube = Cube.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cube_params
      params.require(:cube).permit(:name, cards: [])
    end
end
