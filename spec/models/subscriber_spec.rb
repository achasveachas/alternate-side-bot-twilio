require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  @valid_number = "+1234567890"
  let(:subscriber) {Subscriber.create(number: @number)}
  let(:no_number_subscriber) {Subscriber.create()}

  let(:invalid_number_subscriber) {Subscriber.create(number: "invalid_number")}

  it "has a phone number" do
    expect(no_number_subscriber).not_to be_valid
    expect(subscriber.number).to eq(@valid_number)
  end

  describe "phone number" do

    it "is a valid number" do
      expect(invalid_number_subscriber).not_to be_valid
    end

  end
end
