FactoryBot.define do
    factory :user do
      email { 'michaela@gmail.com' }
      password  { '112358' }
      username { 'micha1' }
    #   add the following two line probably later:
    #   isAgeOver13 { true }
    #   agreed_to_terms { true }
    end
end 