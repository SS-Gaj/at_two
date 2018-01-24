require 'spec_helper'

describe "Authentication" do

  # Листинг 9.11. Тестирование того, что edit и update действия защищены. 
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
     

			#Листинг 10.23 ...контроля доступа для контроллера Microposts
			describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
			##конец Листинг 10.23
  end
end
end
