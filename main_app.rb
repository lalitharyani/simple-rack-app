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
        body = [{success: "Welcome"}.to_json]
        #headers ['Last-Modified'] = "Mon, 04 Jul 2018 10:00:12 GMT"  ##we can set this header
      when "/search"
        status = 200
        users, max_updated_at = User.search(req.params)
        body = [{users: users}.to_json]
        headers ['Last-Modified'] =  max_updated_at

        if env["HTTP_IF_MODIFIED_SINCE"] && env["HTTP_IF_MODIFIED_SINCE"] == max_updated_at
            status = 304
            body = []
            headers.delete("Content-Type")
        end
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
