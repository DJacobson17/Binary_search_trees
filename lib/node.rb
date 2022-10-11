# frozen_string_literal: true

class Node # rubocop:disable Style/Documentation
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
  end

  def <=>(other)
    data <=> other.data
  end
end

a1 = Node.new(4)
a2 = Node.new(6)
p a1 > a2
