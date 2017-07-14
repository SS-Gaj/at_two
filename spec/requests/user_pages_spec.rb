require 'spec_helper'

describe "UserPages" do
  describe "Регистрация посетителей" do
    it "should have the content 'Sign up'" do
      visit signup_path
      expect(page).to have_content('Регистрация')
      expect(page).to have_title('Регистрация')
    end
  end
end
