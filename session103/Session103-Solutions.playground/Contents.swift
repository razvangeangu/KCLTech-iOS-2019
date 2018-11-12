import Foundation
/*:
 # Recap quiz
 Let's see how much you remember from our second session (102). Complete the next set of challenges and ask for any help if you encounter any difficulties. You have 15 minutes.
 */
/*:
 ## Delegates
 Create a delegate for any **Game** that tracks the start and the end of the game. When game did start add only 10 extra points to the game that is being tracked.
 */
/* Your code goes here */
enum Direction: String {
    case up = "upwards"
    case right = "rightwards"
    case down = "downwards"
    case left = "leftwards"
}

protocol RGGame {
    func play()
    func pause()
    func stop() -> Int
    func move(_ direction: Direction)
    func score(_ value: Int)
}

protocol RGGameDelegate {
    func didStartGame(_ game: RGGame)
    func didEndGame(_ game: RGGame)
}

class RGGameTracker: RGGameDelegate {
    func didStartGame(_ game: RGGame) {
        game.score(10)
        print("Added extra 10 points.")
    }
    
    func didEndGame(_ game: RGGame) {
        print("Do something fancy for the end.")
    }
}

/*:
 ## Protocols
 Create a protocol, **Game**, that describes the actions of a simple game - **play()**, **pause()**, **stop()**, **move()** (should take an argument that describes the direction i.e. *.up*, *.down*, *.left*, *.right*) and **score()** (should have an Int as an argument). Create a class that implements this protocol and prints the actions for all the methods.
 
 Challenge: How can you print the status for *play()* and *pause()* without calling the print method inside the function block?
 */
/* Your code goes here */
class BoardGame: RGGame {
    var delegate: RGGameDelegate?
    
    var totalScore: Int = 0
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                print("User \(oldValue ? "started" : "resumed") playing.")
            } else {
                print("User paused the game.")
            }
        }
    }
    
    func play() {
        isPlaying = true
        
        if totalScore == 0 {
            delegate?.didStartGame(self)
        }
    }
    
    func pause() {
        isPlaying = false
    }
    
    func stop() -> Int {
        let totalScore = self.totalScore
        print("User stopped the game.")
        delegate?.didEndGame(self)
        self.totalScore = 0
        return totalScore
    }
    
    func move(_ direction: Direction) {
        print("User moved \(direction.rawValue).")
    }
    
    func score(_ value: Int) {
        totalScore += value
        print("User scored \(value) \(value > 1 ? "points" : "point"). Total Score: \(totalScore).")
    }
}

//// Uncomment the following lines to test your codes
//let boardGame = BoardGame() //// Should init the game
//boardGame.delegate = BoardGameTracker() //// Should set the delegate
//
//boardGame.play() //// Should print "User started playing."
//boardGame.move(.up) //// Should print "User moved upwards."
//boardGame.score(1) //// Should print "User scored 1 point. Total Score: 1."
//boardGame.pause() //// Should print "User paused the game."
//boardGame.play() //// Should print "User resumed playing."
//boardGame.move(.down) //// Should print "User moved upwards."
//boardGame.score(2) //// Should print "User scored 2 points. Total Score: 3."
//boardGame.stop() //// Should print "User stopped the game." and return the total score

