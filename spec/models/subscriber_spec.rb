require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  let(:subscriber) {Subscriber.create(number: "+123456789")}
  let(:whatsapp_subscriber) {Subscriber.create(number: "whatsapp:+123456789")}
  let(:no_number_subscriber) {Subscriber.create()}
  
  
  it "has a phone number" do
    @valid_number = "+1234567890"
    expect(no_number_subscriber).not_to be_valid
    expect(subscriber.number).not_to be_nil
  end

  it "can subscribe whatsapp numbers" do
    expect(whatsapp_subscriber).to be_valid
    expect(whatsapp_subscriber).to be_whatsapp_subscriber
    expect(subscriber).not_to be_whatsapp_subscriber
  end

end
