class ScientistsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error
    def index
        render json: Scientist.all
    end

    def show
        render json: find_scientist, serializer:FindScientistSerializer
    end 

    def create
        scientist= Scientist.create!(allowed_params)
        render json: scientist, status: 201
    end 

    def update 
        scientist= find_scientist.update!(allowed_params)
        render json: find_scientist, status: 202
    end

    def destroy
        find_scientist.destroy
        head :no_content
    end

    private
    def record_not_found_error(e)
        render json: {error: "#{e.model} not found" }, status: :not_found
    end

    def record_invalid_error(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end 

    def find_scientist
        Scientist.find(params[:id])
    end

    def allowed_params
        params.permit(:name, :field_of_study, :avatar)
    end 


end
