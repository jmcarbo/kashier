class CashRegister < ApplicationRecord
  has_many :cash_register_lines, dependent: :delete_all


  def total 
    total = 0.0
    gross_total = 0.0
    product_count = {}
    extra_units = {}
    extra_units_text =""

    cash_register_lines.each do |l| 
      if product_count[l.product.code]
        product_count[l.product.code]=product_count[l.product.code]+1
      else
        product_count[l.product.code] = 1
      end
      gross_total = gross_total + l.product.price
    end

    cash_register_lines.each do |l| 
      if l.product.from_amount && (product_count[l.product.code] >= l.product.from_amount)
        if l.product.price_discount_type == "extra_unit"
          if !extra_units[l.product.code]
            step = l.product.from_amount + l.product.discount_value

            amount_to_pay = product_count[l.product.code].div(step) * l.product.from_amount * l.product.price
            remaining = product_count[l.product.code].remainder(step)
            remaining_to_pay = 0.0
            extra_units_count = 0.0
            remaining_to_pay = remaining * l.product.price
            if remaining >= l.product.from_amount
              extra_units_count = step - remaining
              extra_units_text = extra_units_text + "#{l.product.code} x #{extra_units_count} "
            end

            total = total + amount_to_pay + remaining_to_pay
            extra_units[l.product.code] = extra_units_count
          end
        elsif l.product.price_discount_type == "absolute"
          total = total + l.product.discount_value
        elsif l.product.price_discount_type == "percent"
          total = total + (l.product.price * l.product.discount_value)
        end
      else
        total = total + l.product.price
      end
    end
    return "#{gross_total.round(2)}€", "#{(gross_total-total).round(2)}€", "#{total.round(2)}€", extra_units_text
  end 
end
