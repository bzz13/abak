module PagesHelper
  #finding tree node by names array path
  def findTreeNamedNode(names, root)
    if names.length == 0
      return root
    else
      if root.nil?
        return nil
      else
        @name = names.shift
        @nodes = root.children.select{|child| child.name == @name}
        unless @nodes.length == 0
          @node = @nodes[0]
          return findTreeNamedNode(names, @node)
        else
          return nil
        end
      end
    end
  end
end
