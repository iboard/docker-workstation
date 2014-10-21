require "spec_helper"

describe "Docker Image Verification" do
  Given(:project_path) { `ls -1d ~/projects`.strip }

  context "has a shared path for project sources" do
    Given(:expected_path) { "/home/developer/projects" }
    Then { expected_path == project_path }
  end
end
