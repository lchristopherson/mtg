class SetsController < ApplicationController
  def create
    set_loader = SetLoader.new

    puts "Loading set: #{set_params[:code]}"

    set_loader.load(set_params[:code])

    render status: :ok
  end

  private

  def set_params
    puts params

    params.require(:set).permit(:code)
  end
end
