

# make these dynamic generated methods to handle any model
# add fuzzy search
# ransack option too
def products
  @products ||= find_products
end

private
def find_products
  Product.find(:all, :conditions => conditions)
end

def keyword_conditions
  ["products.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
end

def minimum_price_conditions
  ["products.price >= ?", minimum_price] unless minimum_price.blank?
end

def maximum_price_conditions
  ["products.price <= ?", maximum_price] unless maximum_price.blank?
end

def category_conditions
  ["products.category_id = ?", category_id] unless category_id.blank?
end

def conditions
  [conditions_clauses.join(' AND '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end

