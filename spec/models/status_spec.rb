require 'rails_helper'

RSpec.describe Status, type: :model do

  let(:suspended_status) {Status.create(body: "Alternate side parking rules are suspended", suspended: true)}
  let(:status_in_effect) {Status.create(body: "Alternate side parking rules are in effect")}
  let(:no_body_status) {Status.create(body: "")}

  describe "body" do
    it "has a body" do
      expect(suspended_status.body).not_to be_empty
    end

    it "is invalid without a body" do
      expect(no_body_status).not_to be_valid
    end
  end

  describe "suspended" do

    it "has a suspended status" do
      expect(suspended_status.suspended).to be true
    end

    it "defaults to false" do
      expect(status_in_effect.suspended).to be false
    end
  end

end
