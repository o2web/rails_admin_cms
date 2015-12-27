require 'rails_helper'

describe CMS::ViewablesController, type: :controller do
  describe "GET create" do
    before(:each) do
      request.env["HTTP_REFERER"] = '/page'
      @params = { list_key: {viewable_type: 'Viewable::Link', view_path: 'cms/pages/page', name: 'test', locale: 'fr' } }
    end

    context "when count = 0 and max = 1" do
      it "creates 1 viewable to edit" do
        get :create, @params.merge(max: 1)
        expect(response).to redirect_to "http://test.host/admin/viewable~link/1/edit"
      end
    end

    context "when count = 1 and max = 1" do
      it "creates no new viewable" do
        FactoryGirl.create(:unique_key)
        get :create, @params.merge(max: 1)
        expect(response).to redirect_to "/page"
      end
    end

    context "when count = 2 and max = 1" do
      it "creates no new viewable" do
        FactoryGirl.create_list(:unique_key, 2)
        get :create, @params.merge(max: 1)
        expect(response).to redirect_to "/page"
      end
    end

    context "when count = 2 and max = Infinity" do
      it "creates 1 viewable to edit " do
        FactoryGirl.create_list(:unique_key, 2)
        get :create, @params.merge(max: 'Infinity')
        expect(response).to redirect_to "http://test.host/admin/viewable~link/3/edit"
      end
    end
  end
end
