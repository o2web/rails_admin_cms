require 'rails_helper'

describe Viewable::Image do
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:image) }
  it { is_expected.to have_one(:unique_key) }
end
