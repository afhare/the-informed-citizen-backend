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

    def update
        user = current_user
        if user && State.find_by(abbreviation: update_user_params[:user_state])
            user.assign_attributes(street_address: update_user_params[:street_address] , city: update_user_params[:city] , user_state: update_user_params[:user_state], zipcode: update_user_params[:zipcode], state_id: State.find_by(abbreviation: update_user_params[:user_state]).id)
            if user.valid?
                user.save

                google_API_Key = 'AIzaSyCWTpEcxECWnmZjKKQN_IkoKZad2G8x740'

                updated_street = user[:street_address]
                reformatted_street = updated_street.split.join('%20')
                city = user[:city]
                reformatted_city = city.split.join('%20')
                api_state = user[:user_state]

                google_API_Link = "https://www.googleapis.com/civicinfo/v2/representatives?key=#{google_API_Key}&address=#{reformatted_street}%20#{reformatted_city}%20#{api_state}"

                google_API_response = RestClient::Request.execute(:method => :get, :url => google_API_Link, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'key': google_API_Key})
                google_API_array = JSON.parse(google_API_response)
            
                representatives = []
                rep_names = Representative.all.map { |rep| rep.name }
                sen_names = Senator.all.map { |sen| sen.name }
                
                google_API_array["officials"].each do |official| 
                    if rep_names.include?(official["name"]) || sen_names.include?(official["name"])
                        representatives.push(official["name"])
                        congressperson = Representative.find_by(name: official["name"])
                        if congressperson
                            user = User.find_by(username: user[:username])
                            connection = Congressrepresentative.new
                            connection.user_id = user.id
                            connection.representative_id = congressperson.id
                            connection.save
                        end
                    end
                end
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

            google_API_Key = 'AIzaSyCWTpEcxECWnmZjKKQN_IkoKZad2G8x740'

                updated_street = user[:street_address]
                reformatted_street = updated_street.split.join('%20')
                city = user[:city]
                reformatted_city = city.split.join('%20')
                api_state = user[:user_state]

                google_API_Link = "https://www.googleapis.com/civicinfo/v2/representatives?key=#{google_API_Key}&address=#{reformatted_street}%20#{reformatted_city}%20#{api_state}"

                google_API_response = RestClient::Request.execute(:method => :get, :url => google_API_Link, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'key': google_API_Key})
                google_API_array = JSON.parse(google_API_response)
            
                representatives = []
                rep_names = Representative.all.map { |rep| rep.name }
                sen_names = Senator.all.map { |sen| sen.name }
                
                google_API_array["officials"].each do |official| 
                    if rep_names.include?(official["name"]) || sen_names.include?(official["name"])
                        representatives.push(official["name"])
                        congressperson = Representative.find_by(name: official["name"])
                        if congressperson
                            user = User.find_by(username: user[:username])
                            connection = Congressrepresentative.new
                            connection.user_id = user.id
                            connection.representative_id = congressperson.id
                            connection.save
                        end
                    end
                end

            token = encode_token({user_id: user.id})
            render json: {jwt: token, username: user.username, name: user.name, street_address: user.street_address, city: user.city, state: {abbreviation: user.user_state, id: user.state.id}, zipcode: user.zipcode, representatives: user.representatives, senators: user.senators}, status: :created
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
            params.require(:user).permit(:name, :username, :password, :address, :street_address, :city, :user_state, :zipcode)
        end

        def update_user_params
            params.require(:user).permit(:name, :username, :password, :address, :street_address, :city, :user_state, :zipcode)
        end
end
