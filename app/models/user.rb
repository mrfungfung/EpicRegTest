require 'digest'
class User
	include MongoMapper::Document
#devise :registerable, :authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable


attr_accessor :password
attr_accessible :name, :email,:password, :password_confirmation
#validates_presence_of :name
EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

#key validates_uniqueness_of :email, String, :case_sensitive => false, :required =>true, :with => EmailRegex, :unique => true
key :email, String, :required =>true, :with => EmailRegex, :unique => true
key :name, String, :required =>true, :maximum => 50
key :password, String, :required =>true
key :password_confirmation, String, :required =>true
key :encrypted_password, String
key :salt, String
timestamps! # This would create a "created_at" and "updated_at" keys on create
#!!! validates_uniqueness_of :email, :case_sensitive => false
#^  is this still unique???

#!!!id

# Automatically create the virtual attribute 'password_confirmation'.
validates_confirmation_of :password
# Password validations.
validates_length_of :password, :within => 6..40
#!!!






end
