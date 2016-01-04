class BaseListPresenter
  attr_reader :context, :list
  alias_method :h, :context

  delegate(
    :[],
    :all?,
    :any?,
    :count,
    :cycle,
    :detect,
    :drop,
    :each,
    :empty?,
    :first,
    :inject,
    :last,
    :map,
    :none?,
    :one?,
    :pop,
    :reduce,
    :reject,
    :reverse,
    :rotate,
    :sample,
    :select,
    :size,
    :shift,
    :shuffle,
    :slice,
    :sort,
    :sort_by,
    :take_while,
    :zip,
    to: :list
  )

  def initialize(list, context)
    @list, @context = list, context
  end
end
