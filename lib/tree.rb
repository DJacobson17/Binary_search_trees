# frozen_string_literal: true
require_relative 'node'

class Tree # rubocop:disable Style/Documentation
  attr_accessor :data, :root

  def initialize(array)
    @data = array.uniq.sort
    @root = build_tree(@data)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.length - 1)/2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return Node.new(value) if node.data.nil?

    return node if node.data == value

    if node.data < value
      node.right ? insert(value, node.right) : node.right = Node.new(value)
    else
      node.left ? insert(value, node.left) : node.left = Node.new(value)
    end
  end

  def minValue(root)
    minv = root.data
    until root.left.nil?
      minv = root.left.data
      root = root.left
    end
    minv
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?

      return node.left if node.right.nil?

      node.data = minValue(node.right)
      node.right = delete(node.data, node.right)
      node
    end
  end

  def find(value, node = @root)
    return node if node.data == value

    return nil if node.data.nil?

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # def level_order(node = @root)
  #   queue = [node]
  #   result = []
  #   return result if node.nil?

  #   until queue.empty?
  #     current_node = queue.shift
  #     result.push(block_given? ? yield(current_node) : current_node.data)
  #     queue << current_node.left unless current_node.left.nil?
  #     queue << current_node.right unless current_node.right.nil?
  #   end
  #   result
  # end

  def level_order(node = @root, result = [], level = 0)
    return result if node.nil?

    result << [] if result.length == level
    result[level].push(block_given? ? yield(node.data) : node.data)
    level_order(node.left, result, level + 1)
    level_order(node.right, result, level + 1)
  end

  def inorder(node = @root, result = [])
    return result if node.nil?

    inorder(node.left, result)
    result.push(block_given? ? yield(node.data) : node.data)
    inorder(node.right, result)
  end

  def preorder(node = @root, result = [])
    if node
      result.push(block_given? ? yield(node.data) : node.data)
      preorder(node.left, result) if node.left
      preorder(node.right, result) if node.right
    end
    result
  end

  def postorder(node = @root, result = [])
    if node
      postorder(node.left, result) if node.left
      postorder(node.right, result) if node.right
      result.push(block_given? ? yield(node.data) : node.data)
    end
    result
  end

  def height(node = @root, to_leaf = -1)
    return to_leaf if node.nil?

    to_leaf += 1
    [height(node.left, to_leaf), height(node.right, to_leaf)].max

  end

  def depth(node, parent_node = @root, edges = 0)
    return edges if node == parent_node

    edges += 1
    if node < parent_node
      depth(node, parent_node.left, edges)
    else
      depth(node, parent_node.right, edges)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    array = inorder
    @root = build_tree(array)
  end


end
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)
p t.pretty_print
p t.balanced?



