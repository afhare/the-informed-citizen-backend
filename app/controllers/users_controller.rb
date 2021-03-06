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
            render json: {jwt: token, username: user.username, name: user.name, state: {abbreviation: user.user_state, id: user.state.id}, representatives: user.representatives, senators: user.senators}, status: :accepted
        else
            render json: { message: 'User not found'}
        end
    end

    def update
        user = current_user
        if user && State.find_by(abbreviation: update_user_params[:user_state])
            user.assign_attributes(user_state: update_user_params[:user_state], state_id: State.find_by(abbreviation: update_user_params[:user_state]).id)
            if user.valid?
                user.save
                redirect_to user_path(user)
            else 
                render json: { message: 'Unable to update your profile with the information provided.'}
            end
        else
            render json: { message: 'Unable to update your address. Please verify your account, and/or the address entered.'}
        end
    end

    def create
        user = User.new(new_user_params)
        user.state = State.find_by(abbreviation: user.user_state)

        if user.valid?
            user.save
            token = encode_token({user_id: user.id})
            render json: {jwt: token, username: user.username, name: user.name, state: {abbreviation: user.user_state, id: user.state.id}, representatives: user.representatives, senators: user.senators}, status: :created
        else
            render json: {error: 'Unable to create user'}, status: :unaccepted
        end
    end

    def login
        user = User.find_by(username: login_params[:username])
        if user && user.authenticate(login_params[:password])
            token = encode_token({user_id: user.id})
            render json: {jwt: token, username: user.username, name: user.name, state: {abbreviation: user.user_state, id: user.state.id}, representatives: user.representatives, senators: user.senators}, status: :accepted
        else
            render json: {error: 'Invalid username or password'}, status: :unauthorized
        end
    end

    def destroy
        user = User.find_by(username: delete_params[:username])
        if user 
            user.destroy
            render json: {message: 'Successfully deleted user account.'}, status: :accepted 
        else
            render json: {error: 'Invalid request'}, status: :unauthorized
        end
    end

    private
        def login_params
            params.require(:user).permit(:username, :password)
        end

        def delete_params
            params.require(:user).permit(:username)
        end

        def new_user_params
            params.require(:user).permit(:name, :username, :password, :user_state)
        end

        def update_user_params
            params.require(:user).permit(:name, :username, :password, :user_state)
        end
end
