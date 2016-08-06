require 'rails_helper'

describe Article do
  specify 'factory girl' do
    member = FactoryGirl.create(:member)
    expect(member.full_name).to eq('Yamada Taro')
  end
end
