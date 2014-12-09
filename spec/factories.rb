FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password 'qwerty123'
    projects []
    
    trait :with_projects do
      after(:create) do |user, evaluator|
        2.times {
          user.projects << build(:project)
        }
      end
    end
  end

  factory :project do
    sequence(:name) { |n| "Project-#{n}" }
    sequence(:key) { |n| "KEY#{n}" }
    status "todo"
    
    users []
    association :user, factory: :user, strategy: :build
    
    trait :in_progress_status do 
      status "progress"
    end
    trait :in_done_status do 
      status "done"
    end
    trait :in_failed_status do 
      status "failed"
    end
    
    trait :with_users do
      after(:create) do |project, evaluator|
        2.times {
          project.users << build(:user)
        }
      end
    end
  end
end
