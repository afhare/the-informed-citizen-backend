class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 't0k3nK33')
    end

    def authorized_header
        request.headers['Authorization']
    end

    def decoded_token
        if authorized_header
            token = authorized_header.split(' ')[1]
            begin 
                JWT.decode(token, 't0k3nK33', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        render json: { message: 'Please log in to access your account'}, status: :unauthorized unless logged_in?
    end
end
