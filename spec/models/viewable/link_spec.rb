require 'rails_helper'

describe Viewable::Link do
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:page) }
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:target_blank) }
  it { is_expected.to respond_to(:turbolink) }
  it { is_expected.to have_one(:unique_key) }
end
