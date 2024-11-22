class Node
	include Comparable

	attr_accessor :left, :right, :data

	def initialize(left: nil, right:nil, data:)
		self.data = data
		self.left = left
		self.right = right		
	end

	def <=>(other)
		self.data <=> other.data
	end

	def each(&block)
		self.block.call
		left.each(&block) if left
		right.each(&block) if right
	end

	def to_s
		data.to_s
	end
end