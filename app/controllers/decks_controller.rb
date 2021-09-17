class DecksController < ApplicationController
  include Secured

  before_action :set_deck, only: [:show, :destroy]

  def index
    decks = Deck.where(user: user)

    render json: decks.map { |d| { name: d.name, date: d.created_at, id: d.id } }
  end

  # GET /decks/1
  def show
    respond_to do |format|
      # TODO allow if admin
      if @deck.user != user
        render json: { error: 'Cannot view deck owner by another user' }, status: :forbidden
      else
        format.json { render json: @deck.to_json }
        format.text { render plain: @deck.to_text }
      end
    end
  end

  # GET /decks/current
  def current
    deck = Deck.where(user: user).last

    if deck.nil?
      render json: { error: 'No deck found' }, status: :not_found
    else
      render json: deck.to_json
    end
  end

  # DELETE /decks/1
  def destroy
    if @deck.user != user
      render json: { error: 'Cannot delete deck owner by another user' }, status: :forbidden
    else
      @deck.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deck_params
      params.require(:deck).permit(:name)
    end
end
