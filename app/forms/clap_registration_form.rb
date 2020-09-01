class ClapRegistrationForm
	include ActiveModel::Model
	DEFAULT_ITEM_COUNT = 5
	attr_accessor :claps

	def initialize(attributes = {})
		super attributes
		self.claps = DEFAULT_ITEM_COUNT.times.map { Forms::Clap.new } unless claps.present?
	end

	def claps_attributes=(attributes)
		self.claps = attributes.map do |_, clap_attributes|
			Forms::Clap.new(clap_attributes)
		end
	end

	def valid?
		target_claps.map(&:valid?).all?
	end

	def save
		return false unless valid?

		Clap.transaction { target_claps.each(&:save!) }
		true
	end

	def target_claps
		claps.select { |v| ActiveRecord::Type::Boolean.new.cast(v.register) }
	end
end
