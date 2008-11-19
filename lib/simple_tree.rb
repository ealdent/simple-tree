#
# Ruby Tree Interface by Jason M. Adams.  Distributed under the BSD license, please see LICENSE for more information.
#
# To use this interface, drop it in your current class with +include+.
# You must then simply implement the +parent+ and +children+ methods.
#  * +parent+ returns the parent node of the current node or else nil if it's a root
#  * +children+ returns an +Array+ of all children of this node or an empty +Array+ if it is a leaf node
#
module SimpleTree
  def parent() raise "parent must be overridden"; end
  def children() raise "children must be overridden"; end
  

  #
  # Return whether this node is a leaf node in the hierarchy.
  #
  def is_leaf?
    if children.size == 0
      true
    else
      false
    end
  end


  #
  # Determine whether this is the root node in the hierarchy.
  #
  def is_root?
    if parent
      false
    else
      true
    end
  end
  
  
  #
  # Determine whether the node has a parent.
  #
  def has_parent?
    not is_root?
  end
  
  
  #
  # Determine whether the node has children.
  #
  def has_children?
    not is_leaf?
  end


  #
  # Return the height of this subtree.  A single node has height 1.
  #
  def height
    heights = children.map {|child| child.height}
    return 1 if heights.size == 0
    return heights.max + 1
  end


  #
  # Return an array containing the siblings of the current node.
  #
  def siblings
    # handle case where this is the root node
    return Array.new unless parent

    sibs = Array.new
    parent.children.each do |child|
      next if child.id == self.id
      sibs << child
    end

    sibs
  end


  #
  # Return every node descending from this node's parent (except this node).
  # This include all of the node's descendants.
  #
  def family
    if parent
      fam = [parent] + parent.descendants
    else
      fam = descendants
    end

    fam.delete(self)
    fam
  end


  #
  # Return an array containing every descendant of the current node.
  #
  def descendants
    d = Array.new

    children.each do |child|
      d << child
      d << child.descendants
    end

    d.flatten
  end


  #
  # Return the grandparent of this node.
  #
  def grandparent
    parent.parent if parent     # returns nil by default if no parent
  end


  #
  # Return all the leaf nodes having the current node as an ancestor.
  #
  def leaves
    outp = Array.new
    children.each do |child|
      if child.is_leaf?
        outp << child
      else
        outp << child.leaves
      end
    end

    outp.flatten
  end


  #
  # Helper method for to_s, returns a tree representation of the subtree
  # rooted at this node.  This assumes some sort of identifier is specified
  # for the object being called (self.name, self.identifier, etc)
  # 
  def tree_rep(depth=0)
    if self.name
      ident = self.name
    elsif self.identifier
      ident = self.identifier
    else
      ident = self.object_id
    end
    if depth > 0
      outp = " #{(["    "] * (depth - 1)).join("|")}\\- #{ident}\n"
    else
      outp = "#{ident}\n"
    end
    children.each do |child|
      outp += child.tree_rep(depth + 1)
    end
    outp
  end

end