require 'yaml'
class User

	PER_PAGE = 5

	def initialize
	end

	class << self
      
		def search(params)
			users = {}
			http_max_updated_at = ""
			q = params["name"]
			offset, limit = get_offset_and_limit(params["page"])
			if q && q != ""
				users_data = parse_file
				users = users_data.select{|key, value| value["name"] == q}.values[offset, limit]
				if users
				   users = users.first(PER_PAGE)
				   max_updated_at = users.sort_by!{|k,v| DateTime.strptime(k["updated_at"], '%Y-%m-%d %H:%M:%S') }.last["updated_at"] 
				   if max_updated_at
				   	http_max_updated_at = DateTime.strptime(max_updated_at, '%Y-%m-%d %H:%M:%S').httpdate
				   end
				end
			end
			
			#return users json
			return users, http_max_updated_at
		end


		def parse_file
			YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'user_fixture.yml'))
		end


		def get_offset_and_limit(page)
		      page = page ? page.to_i : 1
		      offset = (page - 1) * PER_PAGE + (page == 1 ? 0 : 1)
		      limit =  (offset - 1) + PER_PAGE + 1

		      return offset, limit
		end

	end



end