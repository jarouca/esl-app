require 'rails_helper'

RSpec.describe Bank, type: :model do
  it { should have_valid(:title).when('grammar class vocabulary', 'level three vocabulary') }
  it { should have_valid(:user_id).when(13, 201) }

  it { should_not have_valid(:title).when(nil, '') }
  it { should_not have_valid(:user_id).when('three', 'fifteen') }

end
