Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://my-portfolio-1-9d2k.onrender.com/' # Update this to the origin you want to allow

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
