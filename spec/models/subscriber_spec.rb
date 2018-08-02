require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  let(:subscriber) {Subscriber.create(number: @valid_number)}
  let(:whatsapp_subscriber) {Subscriber.create(number: "invalid_number")}
  let(:no_number_subscriber) {Subscriber.create()}
  
  
  it "has a phone number" do
    @valid_number = "+1234567890"
    expect(no_number_subscriber).not_to be_valid
    expect(subscriber.number).to eq(@valid_number)
  end

end
