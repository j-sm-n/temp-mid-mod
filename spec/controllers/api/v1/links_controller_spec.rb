require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do
  include LoginHelpers

  before(:each) do
    @user = create(:user)

    login_user(@user)
  end

  describe "GET #index" do
    context "with user signed in" do
      it "returns all link data belonging to that user" do
        link_1 = create(:link, user_id: @user.id)
        link_2 = create(:link, title: "Facebook", url: "https://facebook.com", user_id: @user.id)
        link_3 = create(:link, title: "Twitter", url: "https://twitter.com", user_id: @user.id)

        get :index
        parsed_response = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_response).to be_a(Array)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new link" do
        expect {
          post :create, params: attributes_for(:link)
        }.to change(Link, :count).by(1)
        expect(response.status).to eq(201)
      end

      it "assigns a newly created link as @link" do
        post :create, params: attributes_for(:link)

        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "returns json for created link" do
        post :create, params: attributes_for(:link)
        parsed_response = JSON.parse(response.body)
        expected = {
          "user_id" => @user.id,
          "title" => "Turing",
          "url" => "http://turing.io",
          "read" => false
        }

        expect(parsed_response).to include(expected)
      end
    end

    context "with missing params" do
      it "assigns a newly created but unsaved link as @link" do
        post :create, params: attributes_for(:link, title: nil)

        expect(assigns(:link)).to be_a_new(Link)
        expect(response.status).to eq(500)
      end

      it "returns missing title message" do
        post :create, params: attributes_for(:link, title: nil)

        expected_error = ["Title can't be blank"]
        actual_error = JSON.parse(response.body)

        expect(actual_error).to eq(expected_error)
      end

      it "returns missing url message" do
        post :create, params: attributes_for(:link, url: nil)

        expected_error = ["Url can't be blank", "Url is invalid"]
        actual_error = JSON.parse(response.body)

        expect(actual_error).to eq(expected_error)
      end

      it "returns invalid url message" do
        post :create, params: attributes_for(:link, url: "nil")

        expected_error = ["Url is invalid"]
        actual_error = JSON.parse(response.body)

        expect(actual_error).to eq(expected_error)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      xit "updates the requested link" do
        link = create(:link, user_id: @user.id)
        put :update, params: attributes_for(:link, title: "New name"), id: link.to_param
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
