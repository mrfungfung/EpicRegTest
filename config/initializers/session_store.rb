# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_EpicRegTest_session',
  :secret      => '0270102403528fb05335eb7ff0fc09e0a86cd812c53bd0c90331c61f5054ab0c99e165035d3a9d4e18c20d4248ace987fd7a17eb92af079c35a2f657d6bbdafd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
