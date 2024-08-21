module ApplicationHelper 
  def formatted_currency(price)
    format('$%.2f', price)
  end
end
