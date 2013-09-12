require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../bowling_game'

describe BowlingGame do
  describe '.initialize' do
    it "sets @rolls to an empty array" do
      game = BowlingGame.new

      expect(game.rolls).to eq([])
    end
  end

  describe '#score' do
    it "scores the game as 0 when only gutter balls are thrown" do
      game = BowlingGame.new
      20.times { game.roll(0)}

      expect(game.score).to eq(0)
    end
  end
end