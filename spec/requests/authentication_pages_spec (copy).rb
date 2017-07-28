require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
      
      it { should have_content('Sign in') }
      it { should have_title('Sign in') }

      describe "with invalid information" do
        before { click_button "Sign in" }

          it { should have_title('Sign in') }
          it { should have_selector('div.alert.alert-error') }
      end
      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
	      # в Листинг 9.5 нижеследующие 5 строк заменены на одну = 6-ю
        #before do
        #  fill_in "Email",    with: user.email.upcase
        #  fill_in "Password", with: user.password
        #  click_button "Sign in"
        #end
        before { sign_in user }

        it { should have_title(user.name) }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Settings',    href: edit_user_path(user)) }
        it { should have_link('Sign out',    href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
    end
  end
  # Листинг 9.11. Тестирование того, что edit и update действия защищены. 
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }



    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
    # Листинг 9.13. Тестирование того, что действия edit и update требуют правильного пользователя. 
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
