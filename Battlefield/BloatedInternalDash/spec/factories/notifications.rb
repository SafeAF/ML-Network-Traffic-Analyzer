FactoryGirl.define do
  factory :notification do
    machine nil
user nil
server nil
message "MyString"
priority 1
source "MyString"
destination "MyString"
cluster nil
service nil
application nil
  end

end
