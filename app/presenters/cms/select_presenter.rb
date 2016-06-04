class CMS::SelectPresenter < CMS::PagePresenter
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