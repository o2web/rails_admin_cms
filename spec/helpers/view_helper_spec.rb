require 'rails_helper'

RSpec.describe CMS::ViewHelper, type: :helper do
  describe "#cms_body_class" do
    before(:each) do
      I18n.locale = :fr
      allow(controller).to receive(:action_name).and_return('show')
      allow(params).to receive(:[]).with(:cms_body_class).and_return('show')
    end

    it "generate contextual classes" do
      expect(helper.cms_body_class).to eql("show cms-view cms-view-show fr")
    end

    it "adds other classes" do
      expect(helper.cms_body_class('one', 'two')).to eql("show cms-view cms-view-show fr one two")
    end
  end
end
