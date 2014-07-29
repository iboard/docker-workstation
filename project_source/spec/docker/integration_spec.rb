require "spec_helper"


describe "Docker Image Verification" do

  let(:project_path) { `ls -1d ~/projects`.strip }
  let(:expected_path) { "/home/developer/projects" }


  it "has a shared path for project sources" do
    expect(project_path).to eq(expected_path)
  end

end
