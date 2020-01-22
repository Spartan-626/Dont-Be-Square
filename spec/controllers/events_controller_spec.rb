require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "events#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "events#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end    
  end

  describe "events#create action" do
    it "should successfully create a new event in our database" do
      post :create, params: { event: { description: 'Dungeons & Dragons Campaign Run' } }
      expect(response).to redirect_to root_path

      event = Event.last
      expect(event.description).to eq('Dungeons & Dragons Campaign Run')
    end

    it "should properly deal with validation errors" do
      post :create, params: { event: { description: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Event.count).to eq 0
    end
  end
end
