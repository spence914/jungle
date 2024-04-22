require 'rails_helper'

RSpec.describe User, type: :model do


  describe 'Validations' do


    it "should be valid with all fields filled in" do
      user = User.new(first_name: "test", last_name: "tester", email: "test@test.com", password: "hunter2", password_confirmation: "hunter2")
      expect(user).to be_valid
    end
  
    it "should be invalid without a password" do
      user = User.new(first_name: "test", last_name: "tester", email: "test@test.com", password: nil, password_confirmation: "hunter2")
      expect(user).not_to be_valid
    end

    it "should be invalid without a password confirmation" do
      user = User.new(first_name: "test", last_name: "tester", email: "test@test.com", password: "hunter2", password_confirmation: nil)
      expect(user).not_to be_valid
    end

    it "should be invalid without a first name" do
      user = User.new(first_name: nil, last_name: "tester", email: "test@test.com", password: "hunter2", password_confirmation: "hunter2")
      expect(user).not_to be_valid
    end

    it "should be invalid without a last name" do
      user = User.new(first_name: "test", last_name: nil, email: "test@test.com", password: "hunter2", password_confirmation: "hunter2")
      expect(user).not_to be_valid
    end

    it "should be invalid without an email" do
      user = User.new(first_name: "test", last_name: "tester", email: nil , password: "hunter2", password_confirmation: "hunter2")
      expect(user).not_to be_valid
    end

    it "validates uniqueness of email, ignoring case" do
      user1 = User.create!(first_name: "test1", last_name: "tester", email: "test@test.com", password: "hunter2", password_confirmation: "hunter2")
      user2 = User.new(first_name: "test2", last_name: "tester", email: "TEST@test.com", password: "hunter2", password_confirmation: "hunter2")

      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end

    it "should be invalid if passsword an confirmation do not match" do
      user = User.new(first_name: "test", last_name: "tester", email: "test@test.com", password: "hunter2", password_confirmation: "hunter3")
      expect(user).not_to be_valid
    end

    it "should be invalid with a short password" do
      user = User.new(first_name: "test", last_name: "tester", email: "test@test.com", password: "test", password_confirmation: "test")
      expect(user).not_to be_valid
    end


  end



  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create!(first_name: "test", last_name: "tester", email: "test@example.com", password: "hunter2", password_confirmation: "hunter2")
    end

    context 'when credentials are valid' do
      it 'returns the user' do
        user = User.authenticate_with_credentials("test@example.com", "hunter2")
        expect(user).to eq(@user)
      end
    end

    context 'when credentials are invalid' do
      it 'returns nil' do
        user = User.authenticate_with_credentials(" test@example.com ", "hunter1")
        expect(user).to eq(nil)
      end
    end

    context 'when email has extra whitespace' do
      it 'still returns the user' do
        user = User.authenticate_with_credentials(" test@example.com ", "hunter2")
        expect(user).to eq(@user)
      end
    end

    context 'when email has is capitalized' do
      it 'still returns the user' do
        user = User.authenticate_with_credentials(" TEST@example.com ", "hunter2")
        expect(user).to eq(@user)
      end
    end


  end
end
