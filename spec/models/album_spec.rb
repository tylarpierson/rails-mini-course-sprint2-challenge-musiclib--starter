require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "validations" do
    it "is valid" do
      # instantiate a valid album and ensure it is valid
    end

    it "is invalid without a name" do
      # instantiate an album without a name and ensure it is invalid
    end
  end

  describe "attributes" do
    it "has expected attributes" do
      # ensure exactly the expected attributes are present on an album
    end
  end
end
