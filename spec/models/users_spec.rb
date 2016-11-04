require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should be valid with good data' do
      @usr = User.new(
        first_name: 'Foo',
        last_name: 'Bar',
        email: 'foo@bar.com',
        password: 'asdfasdf',
        password_confirmation:'asdfasdf'
        )
      @usr.save
      expect(@usr).to be_valid
    end

    it 'should be rejected if first name is not present' do
      @usr = User.new(
        first_name: nil,
        last_name: 'Bar',
        email: 'foo@bar.com',
        password: 'asdfasdf',
        password_confirmation:'asdfasdf'
        )
      @usr.save
      expect(@usr).to_not be_valid
      expect(@usr.errors.messages[:first_name]).to include('can\'t be blank')
      expect(@usr.errors.messages[:first_name]).to include('is too short (minimum is 3 characters)')
    end

    it 'should be rejected if last name is not present' do
      @usr = User.new(
        first_name: 'Foo',
        last_name: nil,
        email: 'foo@bar.com',
        password: 'asdfasdf',
        password_confirmation:'asdfasdf'
        )
      @usr.save
      expect(@usr).to_not be_valid
      expect(@usr.errors.messages[:last_name]).to include('can\'t be blank')
      expect(@usr.errors.messages[:last_name]).to include('is too short (minimum is 3 characters)')
    end

    context 'password' do
      it 'should be rejected if password is under 6 characters' do
        @usr = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          password: 'asdfa',
          password_confirmation:'asdfa'
          )
        @usr.save
        expect(@usr.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
        expect(@usr.errors.full_messages.size).to eq(1)
        expect(@usr).to_not be_valid
      end


      it 'should be rejected if password_confirmation does not match' do

        @usr = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          password: 'asdfasdf',
          password_confirmation:' '
          )
        @usr.save
        expect(@usr.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
        expect(@usr.errors.full_messages.size).to eq(2)
        expect(@usr).to_not be_valid
      end

      it 'should be reject if password_confirmation is cased differently' do

        @usr = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          password: 'asdfasdf',
          password_confirmation:'ASDFASDF'
          )
        @usr.save
        expect(@usr.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
        expect(@usr.errors.full_messages.size).to eq(2)
        expect(@usr).to_not be_valid
      end
    end
    context 'email' do
      it 'should be in email format (_____@____.___)' do
        @usr = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@com',
          password: 'asdfasdf',
          password_confirmation:'asdfasdf'
          )
        # Checking with no .
        @usr.save
        expect(@usr.errors.messages[:email]).to include('is invalid')
        expect(@usr.errors.full_messages.size).to eq(1)
        expect(@usr).to_not be_valid

        # Checking with no @
        @usr[:email] = 'foo.bar'

        @usr.save
        expect(@usr.errors.messages[:email]).to include('is invalid')
        expect(@usr.errors.full_messages.size).to eq(1)
        expect(@usr).to_not be_valid

        # Checking ______.___@___
        @usr[:email] = 'foo.bar@com'

        @usr.save
        expect(@usr.errors.messages[:email]).to include('is invalid')
        expect(@usr.errors.full_messages.size).to eq(1)
        expect(@usr).to_not be_valid
      end

      it 'should be unique' do
        @usr1 = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          password: 'asdfasdf',
          password_confirmation:'asdfasdf'
          )
        @usr2 = User.new(
          first_name: 'Foo',
          last_name: 'Bar',
          email: 'foo@bar.com',
          password: 'asdfasdf',
          password_confirmation:'asdfasdf'
          )

        @usr1.save
        @usr2.save

        expect(@usr2.errors.messages[:email]).to include('has already been taken')
        expect(@usr2.errors.full_messages.size).to eq(1)
      end
        it 'should be unique' do
          @usr1 = User.new(
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'foo@bar.com',
            password: 'asdfasdf',
            password_confirmation:'asdfasdf'
            )
          @usr2 = User.new(
            first_name: 'Foo',
            last_name: 'Bar',
            email: 'FOO@BAR.com',
            password: 'asdfasdf',
            password_confirmation:'asdfasdf'
            )


          @usr1.save
          @usr2.save

          expect(@usr2).to_not be_valid
          # expect(@usr2.errors.messages[:email]).to include('has already been taken')
          # expect(@usr2.errors.full_messages.size).to eq(1)

      end
    end
  end
end
