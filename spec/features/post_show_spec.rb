require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:user1) { create(:user, name: 'John Doe', photo: 'clement-m-F_-0BxGuVvo-unsplash.jpg') }
  let!(:user2) { create(:user, name: 'Abdullah Hassan', photo: 'clement-m-F_-0BxGuVvo-unsplash.jpg') }
  let!(:post1) { create(:post, author: user1, title: 'Post 1') }

  before { visit user_post_path(user1, post1) }

  it 'display post title' do
    expect(page).to have_content(post1.title)
  end

  it 'display post text' do
    expect(page).to have_content(post1.text)
  end

  it 'display author name' do
    create_list(:comment, 3, author: user1, post: post1)
    visit user_post_path(user1, post1)
    expect(page).to have_content(post1.author.name)
  end

  it 'displays the post first 3 comments and how many comments are in a post' do
    comments = create_list(:comment, 3, author: user1, post: post1)

    visit user_post_path(user1, post1)

    expect(page).to have_content("Comments: #{comments.size}")

    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'display the number of likes the post has' do
    expect(page).to have_content('Likes: 0')
  end

  it 'dispaly commentor name' do
    create(:comment, author: user2, post: post1)

    visit user_post_path(user1, post1)

    expect(page).to have_content('Abdullah Hassan')
  end

  it 'create new post' do
    click_link('Add a new comment')
    fill_in 'comment[text]', with: 'hello text'
    click_on('Post comment')
    expect(body).to have_content('hello text')
  end
end
