require_relative '../../../kitchen/data/serverspec_helper.rb'
require_relative '../../../kitchen/data/webhead_shared_tests.rb'

describe 'Afterdark Webhead' do
  webhead_content_tests
  webhead_nginx_http_tests
end
