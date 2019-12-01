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
    found_item = find_item_by_name_in_collection(item[:item], result)
    if found_item
      found_item[:count] += 1
    else
      item[:count] = 1
      result.push(item)
    end
  end
  result
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    found_item = find_item_by_name_in_collection(coupon[:item], cart)
    if found_item && found_item[:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        found_coupon_item = find_item_by_name_in_collection(new_name, cart)
        if found_coupon_item
            found_coupon_item[:count] += coupon[:num]
        else
          coupon_item = {
            item: new_name,
            price: coupon[:cost],
            clearance: cart[coupon[:item]][:clearance],
            count: coupon[:num]
          }
          cart.push(coupon_item)
        end
        found_item[:count] -= coupon[:num]
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
