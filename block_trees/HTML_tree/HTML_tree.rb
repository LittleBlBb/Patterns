require_relative 'Tag'

class HtmlTree
  attr_reader :html_content, :tree
  include Enumerable
  def initialize(html_string)
    @html_content = html_string
    @tree = nil
    parse_html
  end

  def self.from_file(path)
    html_string = File.read(path)
    self.new(html_string)
  end

  def each_depth_first(node = self.tree, &block)
    return if node.nil?
    yield node
    node.children.each {|child| each_depth_first(child, &block)}
  end

  def each(&block)
    each_depth_first(self.tree, &block)
  end

  def each_breadth_first
    return if self.tree.nil?
    queue = [self.tree]
    until queue.empty?
      node = queue.shift
      yield node
      queue.concat(node.children)
    end
  end

  def parse_html
    stack = []
    current_tag = nil
    text = ''
    
    self_closing_tags = ["br", "hr", "img", "input", "link", "meta", "doctype"]

    self.html_content.each_char do |char|
      case char
      when '<'
        unless text.strip.empty?
          stack.last.text << text.strip if stack.any?
          text = ''
        end
        current_tag = ''
      when '>'
        if current_tag.start_with?('/')
          finished_tag = stack.pop
          if stack.empty?
            self.tree = finished_tag
          else
            stack.last.children << finished_tag
          end
        else
          tag_name, attributes = parse_tag(current_tag)
          is_self_closing = self_closing_tags.include?(tag_name.downcase)
          tag_data = Tag.new(tag_name, attributes, '')

          if is_self_closing
            if stack.empty?
              self.tree = tag_data
            else
              stack.last.children << tag_data
            end
          else
            stack << tag_data
          end
        end
        current_tag = nil
      else
        current_tag.nil? ? text << char : current_tag << char
      end
    end
  end

   def parse_tag(tag_str)
    parts = tag_str.split
    tag_name = parts.first

    attributes = parts[1..].each_with_object({}) do |attr, hash|
      key, value = attr.split('=')
      value = value&.delete('"')&.gsub(/[,\s]+$/, '') || ''
      hash[key] = value
    end

    [tag_name, attributes]
  end

  def print_tree(node = @tree, indent = 0)
    return if node.nil?

    # Формируем строку атрибутов
    attr_str = node.attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
    attr_str = " #{attr_str}" unless attr_str.empty?
    puts "#{' ' * indent}<#{node.name}#{attr_str}>"

    # Если есть текст внутри тега, выводим его с отступом
    unless node.text.strip.empty?
      puts "#{' ' * (indent + 2)}#{node.text.strip}"
    end

    node.children.each { |child| print_tree(child, indent + 2) }

    puts "#{' ' * indent}</#{node.name}>" unless node.children.empty? && node.text.strip.empty?
  end

  def demonstrate_methods(node = self.tree, indent = 0)
    return if node.nil?

    puts "#{' ' * indent}Tag <#{node.name}>:"
    puts "#{' ' * (indent + 2)}Attributes: #{node.attributes}"
    puts "#{' ' * (indent + 2)}to_s: #{node.to_s}"
    puts "#{' ' * (indent + 2)}to_i: #{node.to_i}"
    puts "#{' ' * (indent + 2)}to_bool: #{node.to_bool}"

    node.children.each {|child| demonstrate_methods(child, indent + 2)}
  end
  private
  def tree=(value)
    @tree = value
  end
end