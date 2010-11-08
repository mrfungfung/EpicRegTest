class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @title = @user.name
    end
    def new
        @user = User.new
        @title = "Sign up"
    end
    def create

        @user = User.new(params[:user])
        #{:name => "fffffff", :email=> "ffff@hotmail.com",:password=> "12341234", :password_confirmation=> "12341234"})
        #puts "123SYCHAN"
        #puts @user.name
        #puts " abc "
        if @user.save
            flash[:success] = "Welcome to the Epic Reg!"
            redirect_to @user
        else
            @title = "Sign up"
            render 'new'
        end
    end
end
