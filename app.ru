use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['lalit', 'lalit@123']
end

use Rack::ConditionalGet
use Rack::ETag

require File.join(File.dirname(__FILE__), 'main_app.rb')
require File.join(File.dirname(__FILE__), 'user.rb')

run MainApp.new
