require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  @valid_number = "+1234567890"
  let(:subscriber) {Subscriber.create(number: @number)}

  @invalid_number = "invalid_number"
  let(:invalid_subscriber) {Subscriber.create(number: @invalid_number)}

  it "has a phone number" do
    expect(subscriber.number).to eq(@valid_number)
  end

  describe "phone number" do

    it "is valid" do
      expect(invalid_subscriber).not_to be_valid
    end

  end
end
