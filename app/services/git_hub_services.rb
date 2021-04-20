class ApiService

  def initialize(token)
    @token = token
  end

  def conn
    Faraday.new(
      url: 'https://api.github.com',
      headers: {
        'Authorization' => "token #{@token}",
        'Accept' => 'application/vnd.github.v3+json'
      }
    ) # Set up a "connection" object
  end

  def get_repo_name
    resp = conn.get('/repos/ignored-comment/little-esty-shop') # sends a request
    JSON.parse(resp.body, symbolize_names: true)
  end

  def self.get_data(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['github_token']}"
    end
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end
end
