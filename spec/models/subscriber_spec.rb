require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  let(:subscriber) {Subscriber.create(number: "+123456789")}
  let(:whatsapp_subscriber) {Subscriber.create(number: "whatsapp:+123456789")}
  let(:invalid_subscriber) {Subscriber.create(number: "invalid-number")}
  let(:no_number_subscriber) {Subscriber.create()}
  
  
  it "has a valid phone number" do
    expect(subscriber).to be_valid
    expect(invalid_subscriber).not_to be_valid
    expect(no_number_subscriber).not_to be_valid
  end

  it "can subscribe whatsapp numbers" do
    expect(whatsapp_subscriber).to be_valid
    expect(whatsapp_subscriber).to be_whatsapp_subscriber
    expect(subscriber).not_to be_whatsapp_subscriber
  end

end
