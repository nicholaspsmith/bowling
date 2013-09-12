require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../bowling_game'

describe BowlingGame do

  let(:game) {BowlingGame.new}

  describe '.initialize' do
    it "sets @rolls to an empty array" do
      expect(game.rolls).to eq([])
    end
  end

  describe '#score' do
    it "scores the game as 0 when only gutter balls are thrown" do
      20.times { game.roll(0)}

      expect(game.score).to eq(0)
    end

    it "scores the game as 20 when one pin is knocked down on each roll" do
      20.times {game.roll(1)}

      expect(game.score).to eq(20)
    end
  end
end