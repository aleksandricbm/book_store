require "rails_helper"

 describe Author, type: :model do
   it { expect(subject).to have_and_belong_to_many :books }
 end

