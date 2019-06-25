require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "validations" do
    it "is valid" do
      artist = Artist.new(name: "Cool Band")
      result = artist.valid?
      errors = artist.errors.full_messages

      expect(result).to be true
      expect(errors).to be_empty
    end

    it "is invalid without a name" do
      artist = Artist.new(name: nil)
      result = artist.valid?
      errors = artist.errors.full_messages

      expect(result).to be false
      expect(errors).to include("Name can't be blank")
    end
  end

  describe "attributes" do
    it "has expected attributes" do
      artist = Artist.new(name: "Cool Band")
      result = artist.attribute_names.map(&:to_sym)

      expect(result).to contain_exactly(
        :name,
        :id,
        :created_at,
        :updated_at
      )
    end
  end
end
