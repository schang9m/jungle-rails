require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @test_user = User.create!(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'bobsmith@gmail.com',
      password: 'qwe123',
      password_confirmation: 'qwe123'
    )
  end
  let(:valid_attributes) do
    {
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'testing@gmail.com',
      password: 'qwe123',
      password_confirmation: 'qwe123'
    }
  end

  describe 'Validations' do
    it 'is valid with all required fields including matching password and password confirmation' do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(valid_attributes.merge(password: nil, password_confirmation: nil))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password confirmation' do
      user = User.new(valid_attributes.merge(password_confirmation: nil))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not valid if password and password confirmation do not match' do
      user = User.new(valid_attributes.merge(password_confirmation: 'wrongpassword'))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid with a duplicate email (case insensitive)' do
      User.create!(valid_attributes)
      duplicate_user = User.new(valid_attributes.merge(email: 'TESTING@gmail.com'))
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'is not valid without a first name' do
      user = User.new(valid_attributes.merge(first_name: nil))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      user = User.new(valid_attributes.merge(last_name: nil))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid without an email' do
      user = User.new(valid_attributes.merge(email: nil))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid if password doesn't meet minimum length" do
      user = User.new(valid_attributes.merge(password: 'abc', password_confirmation: 'abc'))
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    context 'when credentials are correct' do
      it 'returns the user when the correct email and password are provided' do
        user = User.authenticate_with_credentials('bobsmith@gmail.com', 'qwe123')
        expect(user).to eq(@test_user)
      end

      it 'returns the user when email has leading or trailing spaces' do
        user = User.authenticate_with_credentials('  bobsmith@gmail.com  ', 'qwe123')
        expect(user).to eq(@test_user)
      end

      it 'returns the user when email case is different' do
        user = User.authenticate_with_credentials('BOBSMITH@GMAIL.COM', 'qwe123')
        expect(user).to eq(@test_user)
      end
    end

    context 'when credentials are incorrect' do
      it 'returns nil when the email is incorrect' do
        user = User.authenticate_with_credentials('wrong.email@example.com', 'qwe123')
        expect(user).to be_nil
      end

      it 'returns nil when the password is incorrect' do
        user = User.authenticate_with_credentials('bobsmith@gmail.com', 'wrongpassword')
        expect(user).to be_nil
      end

      it 'returns nil when both email and password are incorrect' do
        user = User.authenticate_with_credentials('wrong.email@example.com', 'wrongpassword')
        expect(user).to be_nil
      end
    end
  end
end
