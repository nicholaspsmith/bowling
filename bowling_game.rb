class BowlingGame
  attr_accessor :rolls


  def initialize 
    @rolls = []
    @total_score = 0
    @current_roll = 0
    @rolls_completed = 0
  end

  # Record a roll in the game.
  #
  # pins - The integer number of pins knocked down in this roll.
  #
  # Returns nothing.
  def roll(pins)
    if @rolls_completed < 20
      @rolls.push(pins)
    elsif @rolls_completed == 20
      if last_frame_spare? || last_frame_strike?
        @rolls.push(pins)
      end
    end
    calc_current_roll
  end

  def calc_current_roll
    @rolls_completed = @rolls.count
  end

  # Returns the Integer score for this game. Expects to be run after all rolls
  # for the game have been recorded
  def score
    while @current_roll < @rolls.size - 1
      init_roll

      if strike?
        score_strike
      elsif spare?
        score_spare
      else
        score_roll
      end 
    end
    
    return @total_score
  end
 

  private

  # Initialize values for roll and next_roll
  #
  # Returns nothing.
  def init_roll
    @roll       = @rolls[@current_roll]
    @next_roll  = @rolls[@current_roll + 1]
  end

  # Returns true if the current roll is a strike, false otherwise.
  def strike?
    @roll == 10
  end

  # Scores a strike frame, and adds it to the total score for the game.
  #
  # Returns nothing.
  def score_strike
    @total_score += 10 + @next_roll + @rolls[@current_roll + 2]
    @current_roll += 1
  end

  # Returns true if current roll is a spare, false otherwise
  def spare?
    @roll + @next_roll == 10
  end

  # Scores a spare frame and adds it to the total score.
  #
  # Returns nothing.
  def score_spare
    @total_score += 10 + @rolls[@current_roll + 2]
    @current_roll += 2
  end

  # Scores a roll that was neither a strike nor a spare and adds it to the total score
  #
  # Returns nothing
  def score_roll
    @total_score += @roll + @next_roll
    @current_roll += 2
  end

  def last_frame_spare?
    @rolls[18] + @rolls[19] == 10
  end

  def last_frame_strike?
    @rolls[19] == 10
  end
end