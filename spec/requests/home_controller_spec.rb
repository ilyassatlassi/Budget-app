require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }

      before do
        sign_in user
        get :index
      end

      it 'assigns @categories' do
        expect(assigns(:categories)).to eq(user.categories)
      end

      it 'redirects to categories path' do
        expect(response).to redirect_to(categories_path)
      end
      
    end
  end
end
