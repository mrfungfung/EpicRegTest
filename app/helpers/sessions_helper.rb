module SessionsHelper

    def sign_in(user)
        user.remember_me!
        cookies[:remember_token] = { :value => user.remember_token,
                        :expires => 2.hours.from_now.utc }  #!!! 2 hours expiration!
        self.current_user = user
    end
    
    def current_user=(user)
        @current_user = user
    end
   
    def current_user
        @current_user ||= user_from_remember_token
    end

    def user_from_remember_token
        remember_token = cookies[:remember_token]
        User.find_by_remember_token(remember_token) unless remember_token.nil?
        #!!! what about outdated remember_token?
    end 
    
    def signed_in?
        !current_user.nil?
    end
    
    def sign_out
        cookies.delete(:remember_token)
        self.current_user = nil
    end
end
    
    

