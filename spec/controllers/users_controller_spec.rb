require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before do
    # Simulate a logged-in user
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the users list' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: attributes_for(:user, username: '') }
        }.not_to change(User, :count)
      end

      it 're-renders the new template' do
        post :create, params: { user: attributes_for(:user, username: '') }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #index' do
    before(:each) do
      DatabaseCleaner.clean_with(:truncation)
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @users' do
      user1 = create(:user)
      user2 = create(:user)

      get :index, params: { page: 1 }
      # puts assigns(:users).inspect # Debugging output
      expect(assigns(:users)).to include(user1, user2)
    end
  end

end
