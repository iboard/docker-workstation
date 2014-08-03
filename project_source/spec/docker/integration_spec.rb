
require "spec_helper"

describe 'DOCKER INTEGRATION' do

  Given(:user_home)          { '/home/developer' }
  Given(:project_prefix)     { 'projects' }
  Given(:expected_root_path) { File.join(user_home, project_prefix) }

  context "Project's root exists" do
    When(:local_root_path) { `ls -1d ~/projects`.strip }
    Then { local_root_path.eql?(expected_root_path) }
  end

end
