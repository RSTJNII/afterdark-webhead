source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt'
  cookbook 'curl'
  # Include the fixture cookbook
  cookbook 'test_nginx_certs', path: 'test/fixtures/cookbooks/test_nginx_certs'
end
