require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.create(name: "tesing")  # Adjust based on your Category model setup
  end

  let(:valid_attributes) do
    {
      name: "Sample Product",
      price: 10.0,
      quantity: 5,
      category: @category
    }
  end

  it "is valid with all fields set" do
    product = Product.new(valid_attributes)
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product = Product.new(valid_attributes.merge(name: nil))
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Name can't be blank")
  end

  it "is not valid with a price of 0" do
    product = Product.new(valid_attributes.merge(price: 0))  # Assuming price must be greater than 0
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Price must be greater than 0")
  end

  it "is not valid without a quantity" do
    product = Product.new(valid_attributes.merge(quantity: nil))
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Quantity can't be blank")
  end

  it "is not valid without a category" do
    product = Product.new(valid_attributes.merge(category: nil))
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Category can't be blank")
  end
end
