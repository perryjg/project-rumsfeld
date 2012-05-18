module LiquidFilters
  def formal_date(date)
    date.strftime("%a, %B %d, %Y")
  end
end

Liquid::Template.register_filter(LiquidFilters)