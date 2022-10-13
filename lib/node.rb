# frozen_string_literal: true

class Node # rubocop:disable Style/Documentation
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @right = nil
    @left = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

