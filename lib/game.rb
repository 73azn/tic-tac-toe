# frozen_string_literal: true

require_relative('role')

TABLE = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] # rubocop:disable Style/MutableConstant
CORRECT = ['x', 'o'] # rubocop:disable Style/WordArray
# rubocop:disable Style/WordArray

# class to start the game
class Game
  attr_reader :table

  def initialize
    @select = ['o', 'x']
  end

  def start
    puts 'player 1 choose your play x or o'
    choose = gets.chomp
    if CORRECT.include?(choose.downcase)
      @role = Role.new([[], chose(choose.downcase)], [[], chose(choose)])
    else
      puts 'invalid input'
      start
    end
  end

  # select char to the player
  def chose(char)
    return @select.pop if char.eql? 'x' || select.include?('x') # rubocop:disable Lint/RequireParentheses

    @select.shift
  end

  def show_players
    @role.show_players
  end

  def turn
    player = @role.role
    change_table(play_turn(player), player.data[1])
  end

  def play_turn(player) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    print "player #{player.data[1]} choose: "
    choose = gets.chomp
    if @role.head.data[0].include?(choose) || @role.tail.data[0].include?(choose)
      puts 'the place are taken try again'
      play_turn(player)
    elsif choose.to_i >= 10 || choose.to_i == 0
      puts 'invalid input'
      play_turn(player)
    else
      player.data[0].push(choose.to_i)
      choose
    end
  end
  # build the table before the game

  def build_table
    @table = ''
    TABLE.each do |row|
      row.each do |col|
        @table += "#{col} "
      end
      @table += "\n"
    end
  end

  # change the table for the players
  def change_table(str, player)
    @table = @table.gsub(str, player)
  end

  def show_winner
    puts "#{@winner.data[1]} won"
  end

  def show_table
    puts "#{@table}\n"
  end

  def play_again
    puts 'want to play again? y/n'
    choose = gets.chomp
    choose = choose.downcase
    if choose.eql? 'y'
      play
    elsif choose.eql? 'n'
      # do nothing
    else
      puts 'invalid input'
      play_again
    end
  end

  def play # rubocop:disable Metrics/MethodLength
    start
    build_table
    show_players
    until @role.win || @role.tie
      show_table
      turn
      @winner = @role.check_winner
    end
    show_table
    if @role.win
      show_winner
    else
      puts 'tie game'
    end
    play_again
  end
end
