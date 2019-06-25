require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid" do
      user = User.new(email: "jane@example.com", api_key: "some-api-key")
      result = user.valid?
      errors = user.errors.full_messages

      expect(result).to be true
      expect(errors).to be_empty
    end

    it "is invalid without an email" do
      user = User.new(email: nil, api_key: "some-api-key")
      result = user.valid?
      errors = user.errors.full_messages

      expect(result).to be false
      expect(errors).to include("Email can't be blank")
    end

    it "is invalid without an api key" do
      user = User.new(email: "jane@example.com", api_key: nil)
      result = user.valid?
      errors = user.errors.full_messages

      expect(result).to be false
      expect(errors).to include("Api key can't be blank")
    end
  end

  describe "attributes" do
    it "has expected attributes" do
      user = User.new(email: "jane@example.com", api_key: DEFAULT_API_KEY)
      result = user.attribute_names.map(&:to_sym)

      expect(result).to contain_exactly(
        :email,
        :api_key,
        :id,
        :created_at,
        :updated_at
      )
    end
  end
end
