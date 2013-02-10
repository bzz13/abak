module ApplicationHelper
  include PagesHelper
  # trying to avoid js injection
  # look like SQL injection are stil posible

  # **[string]**      => <b>[string]</b>
  # \\[string]\\      => <i>[string]</i>
  # ((path [string])) => <a href="path">[string]</a>
  def translateToShow(str)
    @result = str
    @result.gsub!(/</, '&lt;')
    @result.gsub!(/>/, '&gt;')
    @result.gsub!(/\*{2}(.+)\*{2}/, '<b>\1</b>')
    @result.gsub!(/\\{2}(.+)\\{2}/, '<i>\1</i>')
    @result.gsub!(/\({2}((\/[\S]+)+)\s+(.+)\){2}/, '<a href="\1">\3</a>')
    return @result
  end
end
