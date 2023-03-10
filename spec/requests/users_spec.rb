require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'displays a list of all users' do
      get users_path
      expect(response).to be_successful
      expect(response.body).to include('Here is a list of users')
    end
    it 'renders the index template' do
      get users_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create!(name: 'Juma', post_counter: 0) }
  end
end
