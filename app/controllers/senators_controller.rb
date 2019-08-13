class SenatorsController < ApplicationController
    def index
        senators = Senator.all 
        render json: senators.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
    end

    def show
        senator = Senator.find_by(id: params[:id])
        if senator
            render json: senator.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Senator not found'}
        end
    end
end
