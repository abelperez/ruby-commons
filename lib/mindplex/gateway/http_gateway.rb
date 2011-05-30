
class HttpGateway
  attr_accessor :endpoint

  # initializes this HTTP Gateway with the specified HTTP
  # endpoint.
  #
  def initialize(endpoint, logger = Logger.new(STDOUT))
    @endpoint = endpoint
    @logger = logger
    logger.debug("init with endpoint: #{endpoint}")
  end

  attr_reader :logger
  
  # invokes an HTTP GET request based on the specified hash
  # of request parameters.
  #
  def get(action, params)
    
    request = query_string(action, params)
    logger.debug("request: #{request}")
    
    url = URI.parse(@endpoint)
    response = Net::HTTP.start(url.host, url.port) { |http|
      http.get(request)
    }
    
    status = success?(response.body)
    gateway_response = GatewayResponse.new(@endpoint, request, response.body, status)       
  end
  
  def post(params)
    
  end
  
  # constructs an HTTP GET request query string based on the
  # specified action and hash of request parameters
  #
  def query_string(action, params)
    payload = action + "?"
    params.each {|key, value| payload += "&#{key}=#{value}" }
    payload
  end
  
  def success?(response)
    if response == "success"
      logger.debug("response: success")
      true
    else
      logger.warn("response: failed")
      false
    end
  end
end
