Rails.application.config.middleware.use OmniAuth::Builder do
  client_id = "983435688358-2dkpdopc8l4ca6uep2f7sip24mb1e01j.apps.googleusercontent.com"
  client_secret = "prYJFFb-X_V90jDNKAW_k7yQ"
  provider :google_oauth2, client_id, client_secret
end