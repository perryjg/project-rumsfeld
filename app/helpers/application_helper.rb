module ApplicationHelper
  include LiquidFilters
  
  def liquidize(content, arguments)
    RedCloth.new( Liquid::Template.parse(content).render(arguments)).to_html
  end
end
