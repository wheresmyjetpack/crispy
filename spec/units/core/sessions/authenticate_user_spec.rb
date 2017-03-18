require 'spec_helper'
require 'core/sessions/authenticate_user'

describe Sessions::AuthenticateUser do
  subject(:auth_user) { described_class }
  let(:email) { 'sally@example.com' }
  let(:password) { 'password' }
  let(:user_relation) { double('relation', find_by_email: user) }
  let(:user) { double('user', authenticate: true) }
  let(:call_args) { {email: email, password: password, user_relation: user_relation} }

  describe '#call' do
    describe 'the user' do
      subject! { user }
      before { auth_user.call(**call_args) }

      it { is_expected.to have_received(:authenticate).with(password) }
    end

    describe 'the relation' do
      subject! { user_relation }
      before { auth_user.call(**call_args) }

      it { is_expected.to have_received(:find_by_email).with(email) }
    end

    context 'when the user credentials are valid' do
      it 'broadcasts ok and returns the user' do
        expect { auth_user.call(**call_args) }.to broadcast(:ok, user)
      end
    end

    context 'when the user credentials are invalid' do
      context 'the email is invalid' do
        let(:user_relation) { double('relation', find_by_email: nil) }
        
        it 'broadcasts danger' do
          expect { auth_user.call(**call_args) }.to broadcast(:danger)
        end
      end

      context 'the password is invalid' do
        let(:user) { double('user', authenticate: false) }

        it 'broadcasts danger' do
          expect { auth_user.call(**call_args) }.to broadcast(:danger)
        end
      end
    end
  end
end
