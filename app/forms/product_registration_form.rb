class ProductRegistrationForm
  include ActiveModel::Model
  DEFAULT_ITEM_COUNT = 5
  attr_accessor :products

  def initialize(attributes = {})
    super attributes
    self.products = DEFAULT_ITEM_COUNT.times.map { Forms::Product.new } unless products.present?
  end

  def products_attributes=(attributes)
    self.products = attributes.map do |_, product_attributes|
      Forms::Product.new(product_attributes)
    end
  end

  def valid?
    target_products.map(&:valid?).all?
  end

  def save
    return false unless valid?

    Product.transaction { target_products.each(&:save!) }
    true
  end

  def target_products
    products.select { |v| ActiveRecord::Type::Boolean.new.cast(v.register) }
  end
end
