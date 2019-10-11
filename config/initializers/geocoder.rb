Geocoder.configure(
  lookup: :google,
  api_key: ENV['GEOCODER_API_KEY'], 
  timeout: 15
)
#created lesson:29- geocoding address
#Do not replace the 'GEOCODER_API_KEY' above, with the actual API key.
#GEOCODER pulls API KEY from application.yml