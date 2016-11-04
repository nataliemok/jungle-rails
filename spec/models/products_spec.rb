require 'rails_helper'
require 'spec_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'should be valid with good data' do
      @cat = Category.new(name: 'Category')

      @prod = Product.new(
        name: 'Name',
        category: @cat,
        description: 'Description',
        quantity: 12,
        price: 9.99
        )
      expect(@prod).to be_valid
    end

    it 'should be valid even without description' do
      @cat = Category.new(name: 'Category')

      @prod = Product.new(
        name: 'Name',
        category: @cat,
        description: nil,
        quantity: 12,
        price: 9.99
        )
      expect(@prod).to be_valid
    end
    
    it 'should should have a name' do
      @cat = Category.new(name: 'Category')

      @prod = Product.new(
        name: nil,
        category: @cat,
        description: 'Description',
        quantity: 12,
        price: 9.99
        )

      expect(@prod).to_not be_valid
      @prod.save
      expect(@prod.errors.messages[:name]).to include("can\'t be blank")
      expect(@prod.errors.full_messages.size).to eq(1)

    end

    it 'should have a category' do

      @prod = Product.new(
        name: 'Name',
        category: nil,
        description: 'Description',
        quantity: 12,
        price: 9.99
        )
        expect(@prod).to_not be_valid
        @prod.save
        expect(@prod.errors.messages[:category]).to include("can\'t be blank")
        expect(@prod.errors.full_messages.size).to eq(1)
    end

    context "quantity" do
      it "should be present" do
        @cat = Category.new(name: "Category")

        @prod = Product.new(
          name: 'Name',
          category: @cat,
          description: 'Description',
          quantity: nil,
          price: 9.99
          )
          expect(@prod).to_not be_valid
          @prod.save
          expect(@prod.errors.messages[:quantity]).to include("can\'t be blank")
          expect(@prod.errors.full_messages.size).to eq(2)
      end

    it "should be a number" do
      @cat = Category.new(name: 'Category')

      @prod = Product.new(
        name: 'Name',
        category: @cat,
        description: 'Description',
        quantity: 'abc',
        price: 9.99
        )
        expect(@prod).to_not be_valid
        @prod.save
        expect(@prod.errors.messages[:quantity]).to include
        [("is not a number")]
        expect(@prod.errors.full_messages.size).to eq(1)
      end
    end


    context "price" do
      it "should be present" do
        @cat = Category.new(name: "Category")

        @prod = Product.new(
          name: 'Name',
          category: @cat,
          description: 'Description',
          quantity: 12,
          price: nil
          )
          expect(@prod).to_not be_valid
          @prod.save
          expect(@prod.errors.messages[:price]).to include("can\'t be blank")
          expect(@prod.errors.full_messages.size).to eq(4)
      end

    it "should be a number" do
      @cat = Category.new(name: 'Category')

      @prod = Product.new(
        name: 'Name',
        category: @cat,
        description: 'Description',
        quantity: 12,
        price: 'abc'
        )
        expect(@prod).to_not be_valid
        @prod.save
        expect(@prod.errors.messages[:price]).to include
        [("is not a number")]
        expect(@prod.errors.full_messages.size).to eq(1)
      end
    end

  end
end
