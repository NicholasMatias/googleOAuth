require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { described_class.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", price: 10.99, published_date: "1925-04-10") }

  context "validations" do
    it "is valid with all attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a title" do
      subject.title = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it "is invalid without an author" do
      subject.author = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:author]).to include("can't be blank")
    end

    it "is invalid without a price" do
      subject.price = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:price]).to include("can't be blank")
    end

    it "is invalid with a negative price" do
      subject.price = -1
      expect(subject).not_to be_valid
      expect(subject.errors[:price]).to include("must be greater than or equal to 0")
    end

    it "is invalid without a published_date" do
      subject.published_date = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:published_date]).to include("can't be blank")
    end
  end
end
