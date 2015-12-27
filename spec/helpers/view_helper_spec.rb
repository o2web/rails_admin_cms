require 'rails_helper'

RSpec.describe CMS::ViewHelper, type: :helper do
  describe "#cms_body_class" do
    before(:each) do
      I18n.locale = :fr
      allow(controller).to receive(:action_name).and_return('show')
      allow(params).to receive(:[]).with(:cms_body_class).and_return('page')
      helper.class.send(:define_method, :edit_mode?) { true }
    end

    it "generate contextual classes" do
      expect(helper.cms_body_class).to eql("page cms-view cms-view-show fr cms-edit-mode")
    end

    it "adds other classes" do
      expect(helper.cms_body_class('one', 'two')).to eql("page cms-view cms-view-show fr cms-edit-mode one two")
    end
  end
end
