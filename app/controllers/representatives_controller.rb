class RepresentativesController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def index
        representatives = Representative.all 
        render json: representatives.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]}}, except: [:created_at, :updated_at])
    end

    def show
        representative = Representative.find_by(id: params[:id])
        if representative
            render json: representative.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}, 
                :house_committees => {:except => [:created_at, :updated_at]}, 
                :joint_committees => {:except => [:created_at, :updated_at]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Representative not found'}
        end
    end

    def compare
        representative = Representative.find_by(id: compare_params[:id])
        if representative
            render json: representative.to_json(:include => {
                :state => {:only => [:id, :name, :abbreviation]}, 
                :house_committees => {:except => [:created_at, :updated_at]}, 
                :joint_committees => {:except => [:created_at, :updated_at]}}, except: [:created_at, :updated_at])
        else
            render json: { message: 'Representative not found'}
        end
    end

    private

    def compare_params
        params.require(:representative).permit(:id)
    end
end
