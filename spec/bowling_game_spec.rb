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
    context 'when only gutter balls are thrown' do
      it "scores the game as 0" do
        20.times { game.roll(0)}

        expect(game.score).to eq(0)
      end
    end
    context "when one pin is knocked down on each roll" do
      it "scores the game as 20" do
        20.times {game.roll(1)}

        expect(game.score).to eq(20)
      end 
    end
    context "when a spare is thrown" do
      it 'records the frame score as 10 plus the number of pins knocked down in the next roll' do
        3.times { game.roll(5) }
        17.times { game.roll(0) }

        expect(game.score).to eq(20)
      end
    end
    context 'when a strike is thrown' do
      it 'records the frame score as 10 plus the total number of pins knocked down in the next two rolls' do
        game.roll(10)
        game.roll(7)
        game.roll(1)
        16.times { game.roll(0) }

        expect(game.score).to eq(26)
      end
    end


    context 'when a non-strike non-spare is thrown in 10th frame' do
      it "does not let the bowler bowl again" do
        20.times { game.roll(1)}
        game.roll(8)
        game.roll(8)
        
        expect(game.score).to eq(20)
      end
    end

    context 'when a spare is thrown in 10th frame' do
      it "lets the bowler bowl one more time" do
        19.times { game.roll(1) }
        game.roll(9)
        game.roll(1)
        game.roll(2)

        expect(game.score).to eq(29)
      end
    end

    context 'when a strike is thrown in 10th frame' do
      it "lets the bowler bowl two more times and no more" do
        19.times { game.roll(1) }
        game.roll(10)
        game.roll(7)
        game.roll(10)
        game.roll(10)
        game.roll(10)

        expect(game.score).to eq(36)
      end
    end

    context 'when two fives are rolled in seperate frames' do
      it "does not count as a spare" do
        game.roll(3)
        game.roll(5)
        game.roll(5)
        game.roll(3)
        game.roll(3)
        game.roll(3)

        expect(game.score).to eq(22)
      end
    end

  end
end