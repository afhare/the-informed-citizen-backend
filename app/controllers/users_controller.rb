class UsersController < ApplicationController
    def index
        users = User.all 
        render json: users.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]},
            :representatives => {:only => [:id, :name, :chamber, :role, :party]}, :senators => {:only => [:id, :name, :chamber, :role, :party]}
            }, except: [:password_digest, :created_at, :updated_at])
    end

    def show
        user = User.find_by(id: params[:id])
        if user
            render json: user(:include => {
                :state => {:only => [:id, :name, :abbreviation]},
                :representatives => {:only => [:id, :name, :chamber, :role, :party]}, :senators => {:only => [:id, :name, :chamber, :role, :party]}
                }, except: [:created_at, :updated_at])
        else
            render json: { message: 'User not found'}
        end
    end
end
