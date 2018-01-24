require 'spec_helper'

describe Micropost do
# Листинг 10.2 Начальный спек Micropost
  let(:user) { FactoryGirl.create(:user) }
	before { @micropost = user.microposts.build(content: "Lorem ipsum") } # заменено на это в Листинге 10.5

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }	#Листинг 10.5. Тесты для ассоциации микросообщения/пользователь
  its(:user) { should eq user }		#Листинг 10.5

## конец Листинг 10.2
# Листинг 10.3. Тест валидации нового микросообщения
	it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
## конец Листинг 10.3
#Листинг 10.14. Тесты валидаций модели Micropost
	describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
##конец Листинг 10.14
end
