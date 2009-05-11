# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bolongu_session',
  :secret      => 'e9ffd1951103c60b9ec256a065eed87df4023f073cd9910d4a530e74ab1b7bf896d8182633fa7839e9b4ab0da9b10451697d1b59247bdb0e5899ddc03c921346'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
