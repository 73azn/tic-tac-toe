# frozen_string_literal: true

require_relative('node')
# this class to choose the role of the player
WIN = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7], [1, 4, 7], [2, 5, 8], [3, 6, 9]]
class Role
  attr_accessor :head, :tail, :point, :win, :tie

  def initialize(player_1, player_2)
    @head = Node.new(player_2)
    @tail = Node.new(player_1)
    @head.next = @tail
    @tail.next = @head
    @point = @head
    @win = false
    @tie = false
  end

  def role
    @point = @point.next
    @point
  end

  def show_players
    print "player 1 choose #{@tail.data[1]} player 2 you are #{@head.data[1]}\n\n"
  end

  def check_winner # rubocop:disable Metrics/AbcSize
    if @win.eql?(false)
      @point.data[0].permutation.each do |prop|
        (0..(prop.length - 3)).each do |numb|
          sub = prop[numb, 3]

          @win = WIN.include?(sub) if WIN.include?(sub).eql? true
          return @point if @win.eql? true
        end
      end
    end
    @tie = true if @head.data[0].length == 4 && @tail.data[0].length == 5
    @point
  end
end
