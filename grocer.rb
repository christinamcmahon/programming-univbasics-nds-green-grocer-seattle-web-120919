def find_item_by_name_in_collection(name, collection)
  collection.keys.each do |item|
    if collection[item][:item] == name
      return collection[item]
    end
    nil
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  # REMEMBER: This returns a new Array that represents the cart. Don't merely change `cart` (i.e. mutate) it. It's easier to return a new thing.
  result = []
  i = 0
  while i < cart.length do 
    # if the item is not found in the result already, add the item and set its count to 1
    if !find_item_by_name_in_collection(cart[i][:item], result)
      result.push(cart[i])
      result[-1][:count] = 1
    else
      # otherwise, find the matching item in result and add 1 to its count
      result_i = 0 
      while result_i < result.length do 
        if result[result_i][:item] == cart[i][:item]
          result[result_i][:count] += 1 
        end
        result_i += 1
      end
    end
    i += 1
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
