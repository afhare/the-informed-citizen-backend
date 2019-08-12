class StatesController < ApplicationController
    def index
        states = State.all 
        render json: states.to_json(:include => {
            :representatives => {:only => [:id, :name, :chamber, :role]}, :senators => {:only => [:id, :name, :chamber, :role]}
            }, except: [:created_at, :updated_at])
    end

    def show
        state = State.find_by(id: params[:id])
        if state
            render json: state.to_json(:include => {
                :representatives => {:only => [:id, :name, :chamber, :role]}, :senators => {:only => [:id, :name, :chamber, :role]}
                }, except: [:created_at, :updated_at])
        else
            render json: { message: 'State not found'}
        end
    end
end
