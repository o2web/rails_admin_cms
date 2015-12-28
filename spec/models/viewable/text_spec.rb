require 'rails_helper'

describe Viewable::Text do
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:html) }
  it { is_expected.to have_one(:unique_key) }
end
