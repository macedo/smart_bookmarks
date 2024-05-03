require "rails_helper"

RSpec.describe User do
  subject!(:user) { create(:user, email: email, password: password) }

  let(:email) { "john@doe.com" }
  let(:password) { "1q2w3e4r" }

  describe ".authenticate" do
    context "with valid credentials" do
      it { expect(described_class.authenticate(email, password)).to eql user }
    end

    context "with invalid credentials" do
      it { expect(described_class.authenticate(email, "invalid password")).to be_nil }
    end
  end

  describe "#username" do
    it { expect(user.username).to eql "john" }
  end
end
