class DraftersController < ApplicationController
  include Secured

  before_action :set_drafter, only: [:show, :update, :destroy]
  before_action :set_draft, only: [:create]

  # GET /drafters
  #
  # Drafters in the current draft
  def index
    current_drafter = Drafter.find_by_user(user)

    if current_drafter.nil? || current_drafter.draft.nil?
      render json: { error: 'User not currently in draft' }, status: :not_found
    else
      render json: current_drafter.draft.drafters, status: :ok
    end
  end

  # GET /drafters/1
  def show
    render json: @drafter
  end

  # POST /drafters
  #
  # Join a draft
  def create
    if false # (TODO) Ensure draft is joinable by user

    elsif false # Ensure draft is in the correct state

    elsif Drafter.in_active_draft?(user) # Ensure user is not in any other drafts
      render json: { error: 'User already in a draft' }, status: :see_other
    elsif @draft.drafters.count >= 8 # Ensure draft is not full
      render json: { error: 'Draft full' }, status: :unprocessable_entity
    else
      # Create deck for drafter here as well?
      @drafter = HumanDrafter.new(
          draft: @draft,
          user: user,
          name: drafter_params[:name]
      )

      if @drafter.save
        render json: @drafter, status: :created
      else
        render json: @drafter.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /drafters/1
  def update
    if @drafter.update(drafter_params)
      render json: @drafter
    else
      render json: @drafter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drafters/1
  def destroy
    @drafter.destroy
  end

  private

  def drafter_params
    params.require(:drafter).permit(:draft_id, :name)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_drafter
    @drafter = Drafter.find(params[:id])
  end

  def set_draft
    @draft = Draft.find(drafter_params[:draft_id])
  end
end
