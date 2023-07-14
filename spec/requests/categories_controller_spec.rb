require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      sign_in user

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:categories)).to eq(user.categories)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      sign_in user

      get :new

      expect(response).to render_template(:new)
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      it 'creates a new category and redirects to index page' do
        user = User.create(name: 'John', email: 'john@example.com', password: 'password')
        sign_in user

        expect do
          post :create, params: { category: { name: 'Category Name', icon: 'category-icon' } }
        end.to change(Category, :count).by(1)

        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to eq('Category was successfully created.')
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        user = User.create(name: 'John', email: 'john@example.com', password: 'password')
        sign_in user

        expect do
          post :create, params: { category: { name: '', icon: 'category-icon' } }
        end.not_to change(Category, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the category and redirects to index page' do
      user = User.create(name: 'John', email: 'john@example.com', password: 'password')
      category = user.categories.create(name: 'Category Name', icon: 'category-icon')
      sign_in user

      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)

      expect(response).to redirect_to(categories_path)
      expect(flash[:notice]).to eq('Category was successfully deleted.')
    end
  end
end
