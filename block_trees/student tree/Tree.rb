require_relative 'Node'
class Tree
	attr_reader :root

	def initialize
		@root = nil
	end

	def insert_node(value)
		new_node = Node.new()
		new_node.value = value
		if root == nil
			root = new_node
		else
			current_node = root
			while(true)
				parent_node = current_node
				if value == current_node.value
					return 
				elsif value < current_node.value
					current_node = current_node.left_child
					if current_node == nil
						parent_node.left_child=new_node
						return						
					end
				else
					current_node = current_node.right_child
					if current_node == nil
						parent_node.right_child=new_node
						return
					end
				end
			end
		end
	end

	def print_tree
		levels = []
		collect_levels(@root, 0, levels)

		levels.each do |level|
			puts level.map
	end
end