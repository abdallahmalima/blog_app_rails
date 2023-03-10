FactoryBot.define do
    factory :user do
      name { 'John' }
      photo { 'https://example.com/image.jpg' }
      bio { 'A user bio.' }
      post_counter { 0 }

    end
  
    factory :post do
      title { 'Post title' }
      text { 'Post text.' }
      comments_counter { 0 }
      likes_counter { 0 }
      association :author, factory: :user
    end
  
    factory :comment do
      association :author, factory: :user
      post
      text { 'Lorem ipsum dolor sit amet.' }
    end
  end
  