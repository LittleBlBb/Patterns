require_relative 'student'
require_relative 'Node'

class Binary_Tree
	include Enumerable

	attr_accessor :root

	def initialize(obj_arr)
		raise ArgumentError, "Array can not be nil or empty" if obj_arr.nil? || obj_arr.empty?

		self.root = Node.new(data: obj_arr[0])

		obj_arr[1..].each do |obj|
			add(self.root, obj)
		end
	end

	def add(node, obj)
		return if obj.nil?

		if obj < node.data
			if node.left.nil?
				node.left = Node.new(data: obj)
			else
				add(node.left, obj)
			end
		else
			if node.right.nil?
				node.right = Node.new(data: obj)
			else
				add(node.right, obj)
			end
		end
	end

	def each(&block)
		traverse_in_order(self.root, &block)
	end

	def traverse_in_order(node, &block)
		return if node.nil?

		traverse_in_order(node.left, &block)
		yield node.data
		traverse_in_order(node.right, &block)
	end

	def to_s
		nlr(self.root).join("\n")
	end

	def nlr(node)
		return [] if node.nil?

		[node.data] + nlr(node.left) + nlr(node.right)
	end

	private :root=, :nlr
end