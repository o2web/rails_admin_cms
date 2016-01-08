ActiveType::Object.class_eval do
  def type_for_attribute(attribute)
    virtual_columns_hash[attribute]
  end
end

ActiveType::VirtualAttributes::VirtualColumn.class_eval do
  def type
    @type_caster.type
  end

  def klass
    case type
    when :integer                     then Fixnum
    when :float                       then Float
    when :decimal                     then BigDecimal
    when :datetime, :timestamp, :time then Time
    when :date                        then Date
    when :text, :string, :binary      then String
    when :boolean                     then Object
    end
  end
end

ActiveType::TypeCaster.class_eval do
  attr_reader :type
end
