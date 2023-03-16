class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # PATCHASE /plants/:id/update
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, status: :accepted

  end

  # DELETE /plant/:id/delete
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  # exception handling our error response
  def render_not_found_response
    render json: { error: "plant not found"  }, status: :not_found
  end

  # using find
  def find_plant
    Plant.find(params[:id])
  end
end
