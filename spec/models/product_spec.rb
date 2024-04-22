require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with all fields filled in" do
      category = Category.new(name: "Test")
      product = Product.new(name: "Sample", price_cents: 10, quantity: 1, category: category)
      expect(product).to be_valid
      
    end
    it "is not valid without a name" do
      category = Category.new(name: "Test")
      product = Product.new(name: nil, price_cents: 10, quantity: 1, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it "is not valid without a price" do
      category = Category.new(name: "Test")
      product = Product.new(name: "Sample", price_cents: nil, quantity: 1, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it "is not valid without a quantity" do
      category = Category.new(name: "Test")
      product = Product.new(name: "Sample", price_cents: 10, quantity: nil, category: category)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "is not valid without a category" do
      product = Product.new(name: "Sample", price_cents: 10, quantity: 1, category: nil)
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end