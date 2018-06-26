require 'json'
class MainApp

  def initialize  
  end

  def call(env)
    req = Rack::Request.new(env)
    headers = {"Content-Type" => "application/json"}
    
    if req.get?
      case req.path_info
      when "/"
        status = 200
        body = [{success:"Welcome to Demp App!!"}.to_json]
      when "/search"
        status = 200

        users = User.search(req.params)
        body = [users]
      else
        status = 404
        body = [{error: "Page not found"}.to_json]
      end

    else
      status = 500
      body = [{error: "This is not a valid request type!! Please use Get request"}.to_json]

    end

    ##return response
    [status, headers, body]
  end

end
