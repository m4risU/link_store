require 'rails_helper'

RSpec.describe SitesController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:site)
  }

  let(:invalid_attributes) {
    attributes_for(:site, url: nil)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all sites as @sites" do
      site = Site.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:sites)).to eq([site])
    end
  end

  describe "GET #edit" do
    it "assigns the requested site as @site" do
      site = Site.create! valid_attributes
      get :edit, {:id => site.to_param}, valid_session
      expect(assigns(:site)).to eq(site)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          description: 'new description'
        }
      }

      it "updates the requested site" do
        site = Site.create! valid_attributes
        put :update, {:id => site.to_param, :site => new_attributes}, valid_session
        site.reload
        expect(site.description).to eq('new description')
      end

      it "assigns the requested site as @site" do
        site = Site.create! valid_attributes
        put :update, {:id => site.to_param, :site => valid_attributes}, valid_session
        expect(assigns(:site)).to eq(site)
      end

      it "redirects to the site" do
        site = Site.create! valid_attributes
        put :update, {:id => site.to_param, :site => valid_attributes}, valid_session
        expect(response).to redirect_to(sites_path)
      end
    end

    context "with invalid params" do
      it "assigns the site as @site" do
        site = Site.create! valid_attributes
        put :update, {:id => site.to_param, :site => invalid_attributes}, valid_session
        expect(assigns(:site)).to eq(site)
      end
    end
  end
end
