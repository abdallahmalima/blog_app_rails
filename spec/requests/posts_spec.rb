require 'rails_helper'

RSpec.describe 'Posts', type: :request do
 
  describe 'GET /show' do
    let(:user) { User.create!(name: 'Alice', post_counter: 0) }
    let(:post) do
      user.posts.create!(title: 'Post 1', text: 'Body 1', comments_counter: 0, likes_counter: 0, created_at: 1.day.ago)
    end
    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template('show')
    end
  end
end
