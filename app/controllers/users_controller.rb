class UsersController < ApplicationController

    before_filter :authenticate, :only => [:index, :edit, :update, :destroy]#, :adminOnce]
    before_filter :correct_user, :only => [:edit, :update]
    before_filter :admin_user, :only => :destroy
    
    def show
        @user = User.find(params[:id])
        @title = @user.name
    end

    def new
        @user = User.new
        @title = "Sign up"
    end

    def index
        @title = "All users"
        @users = User.paginate(:page => params[:page], :per_page =>20)
        # each page set to show 20 users
    end

    def create
        @user = User.new(params[:user])
        #{:name => "fffffff", :email=> "ffff@hotmail.com",:password=> "12341234", :password_confirmation=> "12341234"})
        #puts "123SYCHAN"
        #puts @user.name
        #puts " abc "
        if @user.save
            sign_in @user
            flash[:success] = "Welcome to the Epic Reg!"
            redirect_to @user
        else
            @title = "Sign up"
            render 'new'
        end
    end
    
    def edit
       # @user = User.find(params[:id])
        @title = "Edit user"
    end
    
    def update
        #@user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            flash[:success] = "Profile updated."
            redirect_to @user
        else
            @title = "Edit user"
            render 'edit'
        end
    end
    
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
    end

#!!!    
#    def adminOnce
#        @title = "Making You Aminn!"
#    end
    
    
    private
        def authenticate
            deny_access unless signed_in?
        end
        
        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_path) unless current_user?(@user)
        end
        
        def admin_user
            redirect_to(root_path) unless current_user.admin?
        end
end
