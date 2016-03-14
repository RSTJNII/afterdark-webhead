require_relative '../../../kitchen/data/serverspec_helper.rb'

describe 'Afterdark Webhead' do
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
