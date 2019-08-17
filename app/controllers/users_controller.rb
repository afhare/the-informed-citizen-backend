class UsersController < ApplicationController
    skip_before_action :authorized, only: [:index, :create, :login]

    def index
        users = User.all 
        render json: users.to_json(:include => {
            :state => {:only => [:id, :name, :abbreviation]},
            :representatives => {:only => [:id, :name, :chamber, :role, :party]}, :senators => {:only => [:id, :name, :chamber, :role, :party]}
            }, except: [:password_digest, :created_at, :updated_at])
    end

    def show
        user = current_user
        if user
            token = encode_token({user_id: user.id})
            render json: {jwt: token, username: user.username, name: user.name, street_address: user.street_address, city: user.city, state: {abbreviation: user.user_state, id: user.state.id}, zipcode: user.zipcode, representatives: user.representatives, senators: user.senators}, status: :accepted
        else
            render json: { message: 'User not found'}
        end
    end

    def create
        user = User.new(new_user_params)
        user.state = State.find_by(abbreviation: user.user_state)

        if user.save
            token = encode_token({user_id: user.id})
            render json: {user: user, jwt: token}, status: :created
        else
            render json: {error: 'Unable to create user'}, status: :unaccepted
        end
    end

    def login
        user = User.find_by(username: login_params[:username])
        if user && user.authenticate(login_params[:password])
            token = encode_token({user_id: user.id})
            render json: {jwt: token, username: user.username, name: user.name, street_address: user.street_address, city: user.city, state: {abbreviation: user.user_state, id: user.state.id}, zipcode: user.zipcode, representatives: user.representatives, senators: user.senators}, status: :accepted
        else
            render json: {error: 'Invalid username or password'}, status: :unauthorized
        end
    end

    private
        def login_params
            params.require(:user).permit(:username, :password)
        end

        def new_user_params
            params.require(:user).permit(:name, :username, :password, :street_address, :city, :user_state, :zipcode)
        end
end
