require_relative '../../../kitchen/data/serverspec_helper.rb'

describe 'Afterdark Webhead' do
  describe 'Nginx' do
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
