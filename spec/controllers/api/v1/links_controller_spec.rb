require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do
  include LoginHelpers
  
  before(:each) do
    user = create(:user)

    login_user(user)
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new link" do
        expect {
          post :create, {link: attributes_for(:link)}
        }.to change(Link, :count).by(1)
        expect(response.status).to eq(201)
      end

      it "assigns a newly created link as @link" do
        post :create, {link: attributes_for(:link)}

        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "redirects to the created link" do
        post :create, {link: attributes_for(:link)}
        expect(response).to redirect_to(Artist.last)
      end
    end

    context "with invalid params" do
      xit "assigns a newly created but unsaved link as @link" do
        post :create, {:link => attributes_for(:link, name: nil)}
        expect(assigns(:link)).to be_a_new(Artist)
      end

      xit "re-renders the 'new' template" do
        post :create, {:link => attributes_for(:link, name: nil)}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      xit "updates the requested link" do
        link = create(:link)
        put :update, {:id => link.to_param, :link => attributes_for(:link, name: "New name")}
        link.reload
        expect(link.name).to eq("New name")
      end

      xit "assigns the requested link as @link" do
        link = create(:link)
        put :update, {:id => link.to_param, :link => attributes_for(:link, name: "New name")}
        expect(assigns(:link)).to eq(link)
      end

      xit "redirects to the link" do
        link = create(:link)
        put :update, {:id => link.to_param, :link => attributes_for(:link, name: "New name")}
        expect(response).to redirect_to(link)
      end
    end

    context "with invalid params" do
      xit "assigns the link as @link" do
        link = create(:link)
        put :update, {:id => link.to_param, :link => attributes_for(:link, name: nil)}
        expect(assigns(:link)).to eq(link)
      end

      xit "re-renders the 'edit' template" do
        link = create(:link)
        put :update, {:id => link.to_param, :link => attributes_for(:link, name: nil)}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested link" do
      link = create(:link)
      expect {
        delete :destroy, {:id => link.to_param}
      }.to change(Artist, :count).by(-1)
    end

    xit "redirects to the links list" do
      link = create(:link)
      delete :destroy, {:id => link.to_param}
      expect(response).to redirect_to(links_path)
    end
  end
end
