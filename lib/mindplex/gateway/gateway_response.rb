class GatewayResponse
  attr_accessor :endpoint, :request, :response, :status
  
  def initialize(endpoint, request, response, status)
    @endpoint = endpoint
    @request = request
    @response = response
    @status = status
  end
  
  def inspect
    "endpoint => " + @endpoint + "\n" + "request => " + @request + 
        "\n" + "response => " + @response + "\n" + "status => " + @status.to_s
  end
end