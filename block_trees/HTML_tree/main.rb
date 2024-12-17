require_relative 'HTML_tree'

html = "<html><body><div><br><p>From String</p><p>123</p><img src='image.jpg'></div></body></html>"
tree = HtmlTree.new(html)
puts "HTML-дерево из строки:"
tree.print_tree

# path = "html_text.html"
# tree_from_file = HtmlTree.from_file(path)
# puts "\nHTML-дерево из файла:"
# tree_from_file.print_tree

# puts "\nДемонстрация методов для каждого тега:"
# tree.demonstrate_methods

# puts "\nОбход в глубину"
# tree_from_file.each {|node| puts "<#{node.name}>"}

# puts "\nОбход в ширину"
# tree_from_file.each_breadth_first {|node| puts "<#{node.name}>"}

puts tree.select {|node| node.name == 'p'}