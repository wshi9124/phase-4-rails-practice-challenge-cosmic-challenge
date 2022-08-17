class MissionsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error
    def create
        mission= Mission.create!(allowed_params)
        render json: mission.planet, status: 201
    end 

    private
    def record_invalid_error(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

    def allowed_params
        params.permit(:name, :scientist_id, :planet_id)
    end
end

