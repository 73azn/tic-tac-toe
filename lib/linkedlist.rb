# frozen_string_literal: true

require_relative('node')

# linked list data structure
class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def add(data)
    node = Node.new(data)
    if @head.nil?
      @head = node
      @tail = node
      return
    end
    @tail.next = node
    @tail = node
  end

  def print
    cur = @head
    until cur.nil?
      puts cur.data
      cur = cur.next
    end
  end
end
