def find_item_by_name_in_collection(name, collection)
  collection.each do |item|
    if item[:item] == name
      return item
    end
  end
  nil
end

def consolidate_cart(cart)
  result = []
  cart.each do |item|
    if find_item_by_name_in_collection(item, result)
      result[name][:count] += 1
    else
      result[item] = {
        price: info[:price],
        clearance: info[:clearance],
        count: 1
      }
    end
  end
  result
end

def apply_coupons(cart, coupons)
    coupons.each do |coupon|
        if find_item_by_name_in_collection(coupon[:item], cart) && cart[coupon[:item]][:count] >= coupon[:num]
            new_name = "#{coupon[:item]} W/COUPON"
            if cart[new_name]
                cart[new_name][:count] += coupon[:num]
            else
                cart[new_name] = {
                    price: coupon[:cost],
                    clearance: cart[coupon[:item]][:clearance],
                    count: coupon[:num]
                }
            end
            cart[coupon[:item]][:count] -= coupon[:num]
        end
    end
    cart
end

def apply_clearance(cart)
    cart.keys.each do |item|
        if cart[:item][:clearance]
            cart_item[:price] = (cart_item[:price] * 0.8).round(2)
        end
    end
    cart
end

def checkout(cart, coupons)
    consolidated_cart = consolidate_cart(cart)
    coupons_applied = apply_coupons(consolidated_cart, coupons)
    clearance_applied = apply_clearance(coupons_applied)

    total = 0.0
    clearance_applied.keys.each do |item|
        total += clearance_applied[:item][:price] * clearance_applied[item][:count]
    end
    if total > 100.00
        total = total * 0.9
    end
    total.round(2)
end
