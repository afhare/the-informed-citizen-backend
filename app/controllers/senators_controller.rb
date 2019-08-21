class SenatorsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]
    def index
        senators = Senator.all 
        render json: senators.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
    end

    def show
        senator = Senator.find_by(id: params[:id])
        if senator
            render json: senator.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}, :senate_committees => {:except => [:created_at, :updated_at]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Senator not found'}
        end
    end

    def compare
        senator = Senator.find_by(id: compare_params[:id])
        if senator
            render json: senator.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}, :senate_committees => {:except => [:created_at, :updated_at]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Senator not found'}
        end
    end

    private

    def compare_params
        params.require(:senator).permit(:id)
    end
end
