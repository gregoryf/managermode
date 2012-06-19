Factory.define :user do |u|
    u.sequence(:username) { |n| "username_#{n}" }
    u.sequence(:email) { |n| "email_#{n}@example.com" }
    u.password              "foobar"
    u.password_confirmation "foobar"
end