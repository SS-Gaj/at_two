class Micropost < ActiveRecord::Base
	belongs_to :user	#Листинг 10.7. Микросообщение пренадлежит пользователю
	default_scope -> { order('created_at DESC') }	#Листинг 10.11. Упорядочивание микросообщений с default_scope
	validates :content, presence: true, length: { maximum: 140 }	#Листинг 10.15 */валидация наличия и ограничение длины
	validates :user_id, presence: true
end
