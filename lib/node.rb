# frozen_string_literal: true

# node class to use and store data for other data structure
class Node
  attr_accessor :data, :next, :prev

  def initialize(data)
    @data = data
    @next = nil
    @prv = nil
  end
end
