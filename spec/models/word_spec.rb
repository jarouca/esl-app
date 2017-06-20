require 'rails_helper'

RSpec.describe Word, type: :model do
  it { should have_valid(:part_of_speech).when('noun', 'verb') }
  it { should have_valid(:definition).when('to move quickly', 'hydrogen and oxygen') }

  it { should_not have_valid(:part_of_speech).when(nil, '') }
  it { should_not have_valid(:definition).when(nil, '') }

end
