class BuyInfo < ApplicationRecord

	#購入ステータスをenumで管理
	enum buy_status: { 受付: 0, 商品準備中: 1, 出荷済: 2 }
	enum payments: { 銀行振込: 0, クレジットカード: 1, 代金引換: 2 }
    has_many :buy_items
    belongs_to :user, optional: true

    def total_price
        total_price = 0
        
        buy_items.each do |buy_item|
          total_price = total_price + buy_item.buy_count * buy_item.total_price
        end
    end
  
    validates :addressee, presence: true
    validates :delivery_postcode, presence: true, format:{with: /\A\d{7}\z/}
    validates :delivery_address, presence: true

end
