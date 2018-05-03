class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: Item.find(params[:item_id]).best_day[0], serializer: BestDaySerializer
  end
end
