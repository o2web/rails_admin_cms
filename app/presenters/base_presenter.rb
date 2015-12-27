class BasePresenter
  include ActionView::Helpers

  attr_reader :model, :context
  alias_method :h, :context
  alias_method :m, :model

  def initialize(model, context)
    @model, @context = model, context
  end

  def method_missing(name, *args, &block)
    m.__send__(name, *args, &block)
  end

  def respond_to?(name, include_all = false)
    super || m.respond_to?(name, include_all)
  end
end
