require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  # users show page integration tests
  let!(:user1) { create(:user, name: 'John Doe', photo: 'clement-m-F_-0BxGuVvo-unsplash.jpg') }

  before { visit user_path(user1) }

  it 'displays usernames of all other users' do
    expect(page).to have_content(user1.name)
  end

  it 'displays profile picture for each user' do
    expect(all('img.user-avatar').count).to eq(1)
  end

  it 'displays number of posts each user has written' do
    create_list(:post, 2, author: user1)

    visit user_path(user1)

    expect(page).to have_content('Number of posts: 2')
  end

  it 'display user bio' do
    expect(page).to have_content(user1.bio)
  end

  it 'I can see the users first 3 posts.' do
    create_list(:post, 3, author: user1)

    visit user_path(user1)

    expect(page).to have_css('.post', count: 3)
  end

  it 'dispaly users posts button' do
    visit user_path(user1)
    expect(page).to have_css('section.user a', count: 1)
  end

  it 'redirects to post show page' do
    post1 = create(:post, author: user1, title: 'Post#1')

    visit user_path(user1)

    link = find('article h3 a', match: :first)
    link.click
    expect(current_path).to eq(user_post_path(user1, post1))
  end

  it 'redirects to the user post index page when see all posts is clicked' do
    create(:post, author: user1, title: 'Post 1')

    visit user_path(user1)
    link = find('section.user a', text: 'See all posts', match: :first)
    link.click
    expect(current_path).to eq(user_posts_path(user1))
  end
end
