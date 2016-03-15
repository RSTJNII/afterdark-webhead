require_relative '../../../kitchen/data/serverspec_helper.rb'
require_relative '../../../kitchen/data/webhead_shared_tests.rb'

describe 'Afterdark Webhead' do
  webhead_content_tests
  webhead_nginx_http_tests

  describe 'Nginx HTTPS Vhost' do
    describe file('/etc/nginx/sites-available/000-afterdark-ssl') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe file('/etc/nginx/sites-enabled/000-afterdark-ssl') do
      it { should be_linked_to '/etc/nginx/sites-available/000-afterdark-ssl' }
    end

    describe command('curl https://localhost --cacert /etc/nginx/ssl/afterdark.cert.pem') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(%r{<title>After Dark in CSS</title>}) }
    end

    describe command('echo | openssl s_client -showcerts -connect localhost:443') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(%r{subject=/C=US/ST=Colorado/L=Denver/O=Internet Widgits Pty Ltd/OU=DevOps/CN=localhost}) }
      its(:stdout) { should match(%r{issuer=/C=US/ST=Colorado/L=Denver/O=Internet Widgits Pty Ltd/OU=DevOps/CN=localhost}) }
    end
  end
end
