require 'rails_helper'

describe CMS::ViewablesController, type: :controller do
  before(:each) do
    request.env["HTTP_REFERER"] = '/page'
  end

  describe "#create" do
    let(:params) { { list_key: { viewable_type: 'Viewable::Link', view_path: 'cms/pages/page', name: 'test', locale: 'fr' } } }

    subject { UniqueKey.where(locale: :fr).count }

    context "when count = 0 and max = 1" do
      it "creates 1 viewable to edit" do
        get :create, params.merge(max: 1)
        expect(response).to redirect_to "http://test.host/admin/viewable~link/1/edit"
        is_expected.to eql(1)
      end
    end

    context "when count = 1 and max = 1" do
      it "creates no new viewable" do
        FactoryGirl.create(:unique_key)
        get :create, params.merge(max: 1)
        expect(response).to redirect_to "/page"
        is_expected.to eql(1)
      end
    end

    context "when count = 2 and max = 1" do
      it "creates no new viewable" do
        FactoryGirl.create_list(:unique_key, 2)
        get :create, params.merge(max: 1)
        expect(response).to redirect_to "/page"
        is_expected.to eql(2)
      end
    end

    context "when count = 2 and max = Infinity" do
      it "creates 1 viewable to edit " do
        FactoryGirl.create_list(:unique_key, 2)
        get :create, params.merge(max: 'Infinity')
        expect(response).to redirect_to "http://test.host/admin/viewable~link/3/edit"
        is_expected.to eql(3)
      end
    end
  end

  describe "#update" do
    context "when count = 3" do
      before(:each) do
        FactoryGirl.reload
        FactoryGirl.create_list(:unique_key_fr, 3)
        FactoryGirl.create_list(:unique_key_en, 3)
      end

      subject { UniqueKey.all.map(&:position) }

      it "updates position from 1 to 3" do
        post :update, { id: 1, unique_key: { position: 3 }, format: :js }
        expect(subject).to eql([3,1,2, 3,1,2])
      end

      it "updates position from 3 to 1" do
        post :update, { id: 3, unique_key: { position: 1 }, format: :js }
        expect(subject).to eql([2,3,1, 2,3,1])
      end

      it "updates position from 2 to 2" do
        post :update, { id: 2, unique_key: { position: 2 }, format: :js }
        expect(subject).to eql([1,2,3, 1,2,3])
      end
    end
  end
end
