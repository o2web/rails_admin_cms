class BaseListPresenter
  include ActionView::Helpers
  include Enumerable

  attr_reader :context, :list
  alias_method :h, :context

  delegate :each, :first, :last, :map, to: :list

  def initialize(list, context)
    @list, @context = list, context
  end
end
