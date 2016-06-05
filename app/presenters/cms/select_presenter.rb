class CMS::SelectPresenter < CMS::ElementPresenter
  def option
    [label, m.value]
  end

  def label
    if m.label.blank?
      m.value
    else
      m.label
    end
  end
end