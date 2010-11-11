require 'digest'
class User
	include MongoMapper::Document
#devise :registerable, :authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable


attr_accessor :password
#!!! need to make attr_accessor :password_confirmation ??? or taken care by validates_confirmation_of
attr_accessible :name, :email,:password, :password_confirmation
#validates_presence_of :name  <-- now use :required =>true
EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

key :email, String, :required =>true, :with => EmailRegex, :unique => true
#!!! EmailRegex doesn't check.....
key :name, String, :required =>true, :maximum => 50
#!!! maximum doesn't check
key :password, String, :required =>true, :within =>6..40
key :password_confirmation, String, :required =>true
key :encrypted_password, String
key :salt, String
key :remember_token, String
#!!! how to set which field is the id/key
timestamps! # This would create a "created_at" and "updated_at" keys on create
#!!! ^ need to check that the timestamps are indeed in the database
key :admin, Boolean, :default => false


#!!!
#validates_uniqueness_of :email
#, :case_sensitive => false
#^ without this,  is this still unique???  perhaps just :unique => true is good enough enforcement?

before_save :encrypt_password


# Automatically create the virtual attribute 'password_confirmation'.
validates_confirmation_of :password
# Password validations.
validates_length_of :password, :within => 6..40

#def teetoutput
#puts "123SYCHAN"
#puts self.name
#puts " abc "
#end

    def has_password?(submitted_password)
        encrypted_password == encrypt(submitted_password)
    end

    def self.authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end

    def remember_me!
        self.remember_token = encrypt("#{salt}--#{id}--#{Time.now.utc}")
        #!!! id?
        # save_without_validation  <-- syntax for active reocrd 
        save(:validate => false) 
    end
    

private 

    def encrypt_password
        unless password.nil?
            self.salt = make_salt
            self.encrypted_password = encrypt(password)
        end
    end

    def make_salt
        secure_hash("#{Time.now.utc}#{password}")
    end
    
    def encrypt(string)
        string  #???
        secure_hash("#{salt}#{string}")
    end

    def secure_hash(string)
        Digest::SHA2.hexdigest(string)  #!!! neeed to check that this is random enough?
    end

#!!! is this still necessary or done by user_controller?
#    def create
#        @user = User.new(params[:user])
#        if @user.save
#           redirect_to @user
#        else
#            @title = "Sign up"
#            render 'new'
#        end
#    end

end
