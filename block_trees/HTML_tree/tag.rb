class Tag
	attr_accessor :name, :attributes, :text, :children

	def initialize(name, attributes = {}, text = '', children = [])
		self.name = name
		self.attributes = attributes
		self.text = text
		self.children = children
	end

	def to_s
		self.text
	end

	def to_i
		self.text.to_i
	end

	def to_bool
		!self.text.strip.empty?
	end

	def to_html
		attr_str = self.attributes.map {|k, v| "#{k}=\"#{v}\"" }.join(' ')
		attr_str = " #{attr_str}" unless attr_str.empty?
		"<#{self.name}#{attr_str}>#{self.text}</#{self.text}>"
	end
end