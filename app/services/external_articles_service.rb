class ExternalArticlesService
    BASE_URL = "https://jsonplaceholder.typicode.com"

    def self.fetch_articles
      connection = Faraday.new(url: BASE_URL)
      response = connection.get('/posts')  # The API endpoint still uses 'posts'

      if response.success?
        JSON.parse(response.body)
      else
        []
      end
    end
  end