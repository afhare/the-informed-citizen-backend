class RepresentativesController < ApplicationController
    def index
        representatives = Representative.all 
        render json: representatives.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
    end

    def show
        representative = Representative.find_by(id: params[:id])
        if representative
            render json: representative.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Representative not found'}
        end
    end
end
