require 'yaml'
class User

	attr_reader :name

	def initialize
	end

	class << self
      
		def search(params)
			users = {}
			q = params["name"]
			if q && q != ""
				users_data = parse_file
				users = users_data.select{|key, value| value["name"] == q}.values
			end
			
			#return users json
			{users: users}.to_json
		end


		def parse_file
			YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'user_fixture.yml'))
		end
	end



end