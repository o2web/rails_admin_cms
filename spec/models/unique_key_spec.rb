require 'rails_helper'

describe UniqueKey do
  it { is_expected.to belong_to(:viewable) }
  it { is_expected.to respond_to(:view_path) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:locale) }
end
