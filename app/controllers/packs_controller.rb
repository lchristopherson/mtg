class PacksController < ApplicationController
  include Secured

  before_action :set_pack, only: [:update]
  before_action :set_drafter, only: [:update]

  # PUT /packs/:id
  def update
    if @pack.nil?
      render json: { error: 'No pack available' }, status: :unprocessable_entity
    elsif @drafter.user != user
      render json: { error: 'User does not own the pack' }, status: :forbidden
    else
      begin
        @drafter.handle_pick(@pack, pack_params[:card_id])

        render json: format_pack_response(@drafter.next_pack)
      rescue Pack::CardNotFound => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end

  private

  def format_pack_response(pack)
    return { cards: [] } if pack.nil?

    { id: pack.id, cards: pack.cards.sort.map(&:to_json) }
  end

  def pack_params
    params.require(:pack).permit(:card_id)
  end

  def set_pack
    @pack = Pack.find(params[:id])
  end

  def set_drafter
    @drafter = @pack.drafter
  end
end
