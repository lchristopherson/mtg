class DraftsController < ApplicationController
  include Secured

  before_action :set_draft, only: [:show, :pack, :deck, :drafter, :drafters, :start, :leave, :update, :destroy]

  # GET /drafts
  def index
    render json: Draft.open
  end

  # GET /drafts/1
  def show
    if Drafter.where(user: user, draft: @draft).empty?
      render json: { error: 'User not in draft' }, status: :forbidden
    else
      render json: @draft, status: :ok
    end
  end

  # GET /drafts/current
  def current
    drafters = Drafter.where(user: user)

    if drafters.empty?
      render json: { error: 'User not currently in a draft' }, status: :not_found
    else
      render json: drafters.last.draft
    end
  end

  # GET /drafts/:id/pack
  def pack
    drafter = Drafter.where(user: user, draft: @draft)

    if drafter.empty?
      render json: { error: 'User not in draft' }, status: :forbidden
    else
      raise "This shouldn't happen" if drafter.count > 1

      pack = drafter.first.next_pack

      render json: format_pack_response(pack)
    end
  end

  def deck
    drafter = Drafter.where(user: user, draft: @draft)

    if drafter.empty?
      render json: { error: 'User not in draft' }, status: :forbidden
    else
      raise "This shouldn't happen" if drafter.count > 1

      deck = drafter.first.deck

      render json: deck.to_json
    end
  end

  # GET /drafts/:id/drafter
  def drafter
    drafter = Drafter.where(user: user, draft: @draft)

    if drafter.empty?
      render json: { error: 'User not in draft' }, status: :forbidden
    else
      raise "This shouldn't happen" if drafter.count > 1

      render json: drafter.first
    end
  end

  # GET /drafts/:id/drafters
  def drafters
    if Drafter.where(user: user, draft: @draft).empty?
      render json: { error: 'User not in draft' }, status: :forbidden
    else
      render json: @draft.drafters
    end
  end

  # POST /drafts
  def create
    params = {
        owner: user,
        state: 'QUEUE',
        data: {
            name: draft_params[:name],
            sets: %w(khm khm khm)
            #sets: draft_params[:sets]
        }
    }

    @draft = Draft.new(params)

    if @draft.save
      render json: @draft, status: :created
    else
      render json: @draft.errors, status: :unprocessable_entity
    end
  end

  # POST /drafts/:id/start
  def start
    if @draft.owner == user
      StartDraftJob.perform_later(@draft.id)

      render json: {}
    else
      render json: { error: 'User cannot start draft' }, status: :forbidden
    end
  end

  # POST /drafts/:id/leave
  def leave
    begin
      # TODO handle based on draft state
      @draft.drafters.find_by_user(user).destroy

      render json: {}
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'User not in draft' }, status: :not_found
    end
  end

  # DELETE /drafts/1
  def destroy
    @draft.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_draft
    @draft = Draft.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def draft_params
    params.require(:draft).permit(:name, sets: [])
  end

  def format_pack_response(pack)
    return { cards: [] } if pack.nil?

    { id: pack.id, cards: pack.cards.sort.map(&:to_json) }
  end
end
