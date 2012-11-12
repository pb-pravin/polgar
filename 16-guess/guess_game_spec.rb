require_relative 'guess_game'

describe GuessGame do
    
  it "should display 'Welcome to the Guessing Game' to the standard output when the game begins" do
    fake_console = double('Console').as_null_object
    fake_console.should_receive(:output).with('Welcome to the Guessing Game')
  
    game = GuessGame.new(fake_console)
    game.start
  end
    
  it "should prompt the user to enter the number representing their guess. Prompt should explain to users what they are to do." do
    fake_console = double('Console').as_null_object
    fake_console.should_receive(:prompt).with('Enter a number between 1 and 100 to guess the number')
  
    game = GuessGame.new(fake_console)
    game.start    
  end
  
  it "should perform validation of the guess entered by the user : lower than 1" do
    fake_console = double('Console').as_null_object
    fake_console.stub(:input) { 0 }
  
    game = GuessGame.new(fake_console)
    game.get_user_guess
    
    game.error.should == 'The number must be between 1 and 100'            
  end
  
  it "should perform validation of the guess entered by the user : higher than 100" do
    game = GuessGame.new
    game.guess = 101
    
    game.error.should == 'The number must be between 1 and 100'            
  end
  
  it "should give clue when the input is valid and is less than the computer pick" do
    fake_randomizer = stub(:get => 25)
    fake_console = double('Console').as_null_object
    fake_console.should_receive(:output).with('Your guess is lower')
  
    game = GuessGame.new(fake_console, fake_randomizer)
    game.stub(:random).and_return { 25 }
    game.guess = 10    
  end

  it "should give clue when the input is valid and is greater than the computer pick" do
    fake_randomizer = stub(:get => 25)
    fake_console = double('Console').as_null_object
    fake_console.should_receive(:output).with('Your guess is higher')
  
    game = GuessGame.new(fake_console, fake_randomizer)
    game.guess = 35    
  end

  it "should recognize the correct answer when the guess is correct." do
    fake_randomizer = stub(:get => 25)
    fake_console = double('Console').as_null_object
    fake_console.should_receive(:output).with('Your guess is correct')
  
    game = GuessGame.new(fake_console, fake_randomizer)
    game.guess = 25
  end
  
end