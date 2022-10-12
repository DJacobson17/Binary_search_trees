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


end
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
t = Tree.new(array)
p t
# t.delete(67)
p t.pretty_print


