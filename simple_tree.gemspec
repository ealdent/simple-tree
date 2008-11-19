Gem::Specification.new do |s| 
  s.name = "simple-tree"
  s.version = "0.1.0"
  s.date = "2008-11-19"
  s.authors = "Jason M. Adams"
  s.email = "jasonmadams@gmail.com"
  s.homepage = "http://github.com/ealdent/simple-tree"
  s.platform = Gem::Platform::RUBY
  s.summary = "Interface for very simple trees."
  s.description = "Interface for very simple trees.  You only have to implement parent (returns the single parent of the current node) and children (returns an Array of all the children of this node) and initialize.  Drop this class in via include and presto!"
  s.files = [ 
              "LICENSE",
              "simple_tree.rb"
            ]
  s.has_rdoc = true
end
