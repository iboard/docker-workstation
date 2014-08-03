require "spec_helper"


describe 'Docker Image Verification' do

  Given(:project_path) { `ls -1d ~/projects`.strip }

  context 'shared project sources' do
    When(:expected_path) { "/home/developer/projects" }
    Then { project_path == expected_path }
  end

end
