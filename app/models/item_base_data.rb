class ItemBaseData < ActiveRecord::Base
  attr_accessible :description, :item, :item_dsca
  
  validates_presence_of :item, :description
  
  
  default_scope {order("#{self.table_name}.item ASC")}
  
  def item_dsca
	[self.item.lstrip, self.description].join(" ")
  end
  
end
