class SetsController < ApplicationController
  include Secured

  # GET /sets
  def index
    render json: MtgSet.all
  end

  # GET /sets/:code
  def show
    set = MtgSet.find_by_code(params[:code])

    render json: set.to_json
  end

  # POST /sets
  def create
    cards = SetLoader.new.load_set(set_params[:code])

    Card.create(cards)

    MtgSet.create(name: set_params[:name], code: set_params[:code])

    render status: :ok
  end

  private

  def set_params
    params.require(:set).permit(:code, :name)
  end
end
