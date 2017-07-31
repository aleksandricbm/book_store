require 'rails_helper'

describe Order, type: :model do
   it { expect(subject).to have_many :books }
 end
