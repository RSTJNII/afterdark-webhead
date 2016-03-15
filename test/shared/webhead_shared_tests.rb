# Webhead shared tests: Test definitions common to multiple Kitchen tests

def webhead_content_tests
  describe 'content' do
    describe user('ad-content') do
      it { should exist }
      it { should belong_to_primary_group 'ad-content' }
      it { should have_login_shell '/bin/false' }
    end

    describe group('ad-content') do
      it { should exist }
    end

    describe file('/var/www/afterdark') do
      it { should be_directory }
      it { should be_mode 755 }
      it { should be_owned_by 'ad-content' }
      it { should be_grouped_into 'ad-content' }
    end

    describe command('cd /var/www/afterdark && git remote show origin') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(%r{https://github.com/RSTJNII/after-dark-css.git}) }
    end
  end
end

def webhead_nginx_http_tests
  describe 'Nginx HTTP Vhost' do
    describe file('/etc/nginx/sites-available/000-afterdark') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe file('/etc/nginx/sites-enabled/000-afterdark') do
      it { should be_linked_to '/etc/nginx/sites-available/000-afterdark' }
    end

    describe file('/etc/nginx/sites-enabled/000-default') do
      it { should_not be_file }
    end

    describe command('curl 127.0.0.1') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match(%r{<title>After Dark in CSS</title>}) }
    end
  end
end
