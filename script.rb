class Tree
  def initialize(arr)
    @root = build_tree arr.sort
  end

  def build_tree(arr)
    node = Node.new(arr[arr.length / 2])
    node.left = build_tree arr[0..arr.length / 2 - 1] if arr.length > 1
    node.right = build_tree arr[arr.length / 2 + 1...arr.length] if arr.length > 2
    node
  end

  def insert(data, root = @root)
    return Node.new(data) if root.nil?
    root.right = insert(data, root.right) if data > root.data
    root.left = insert(data, root.left) if data <= root.data
    return root
  end

  def minValueNode(root)
    until root.left.nil?
      root = root.left
    end
    root
  end

  def delete(data, root = @root)
    root if root.nil?
    if data > root.data
      root.right = delete(data, root.right)
    elsif data < root.data
      root.left = delete(data, root.left)
    else
      if root.left.nil? && root.right.nil?
        return nil
      elsif root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end
      temp = minValueNode(root.right)
      root.data = temp.data
      root.right = delete(root.data, root.right)
    end
    root
  end

  def find(data, root = @root)
    return if root.nil?
    return root if root.data == data
    return find(data, root.left) if data < root.data
    return find(data, root.right) if data > root.data
  end

  def processCurrentLevel(root, level, &block)
    return [] if root.nil?
    arr = []
    if level == 0
      return [block.call(root.data)] if block_given?
      return [root.data]
    elsif level > 0
      arr += processCurrentLevel(root.left, level - 1, &block)
      arr += processCurrentLevel(root.right, level - 1, &block)
    end
    arr
  end

  def level_order(root = @root, &block)
    res = []
    height.times { |level| res += processCurrentLevel(root, level, &block).compact }
    res
  end

  def inorder(root = @root, &block)
    return [] if root.nil?
    arr = []
    arr += inorder(root.left, &block)
    block_given? ? arr += [block.call(root.data)] : arr += [root.data]
    arr += inorder(root.right, &block)
    arr
  end

  def preorder(root = @root, &block)
    return [] if root.nil?
    arr = []
    block_given? ? arr += [block.call(root.data)] : arr += [root.data]
    arr += preorder(root.left, &block)
    arr += preorder(root.right, &block)
    arr
  end

  def postorder(root = @root, &block)
    return [] if root.nil?
    arr = []
    arr += postorder(root.left, &block)
    arr += postorder(root.right, &block)
    block_given? ? arr += [block.call(root.data)] : arr += [root.data]
    arr
  end

  def height(root = @root)
    return 0 if root.nil?
    left_height = height(root.left)
    right_height = height(root.right)
    return left_height + 1 if left_height > right_height
    return right_height + 1 if right_height >= left_height
  end

  def depth(node, root = @root, l = 0)
    return if node.nil?
    return l if node == root
    node.data > root.data ? depth(node, root.right, l + 1) : depth(node, root.left, l + 1)
  end

  def balanced?(root = @root)
    return true if root.nil?
    return false if (height(root.left) - height(root.right)).abs > 1
    return false unless balanced?(root.left)
    return false unless balanced?(root.right)
    true
  end

  #pretty_print method that a student wrote and shared on Discord
  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end

  def rebalance
    @root = build_tree(inorder)
  end
end

class Node
  include Comparable
  attr_accessor :left
  attr_accessor :right
  attr_accessor :data

  def initialize(data = nil, left = nil, right = nil)
    @data, @left, @right = data, left, right
  end

  def <=>(other_data)
    data <=> other_data
  end
end