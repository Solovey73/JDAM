//
//  GameModel.swift
//  JDAM
//
//  Created by Dmitry Volkov on 13/02/2025.
//

import UIKit

protocol GameModelDelegate: AnyObject {
    func timerDidUpdate(secondsRemaining: Int)
    func gameDidEnd()
}

class GameModel {
    weak var delegate: GameModelDelegate?
    
    var questions: [Question]
    var punishments: [String]
    var gameState: GameState = .start
    var secondsRemaining: Int
    var countdownTimer: Timer?
    
    init(questions: [Question], punishments: [String]) {
        self.questions = questions
        self.punishments = punishments
        self.secondsRemaining = 10
    }
    
    func startGame() {
        gameState = .inProgress
        secondsRemaining = 10
        startTimer()
    }
    
    func restartGame() {
        gameState = .start
        secondsRemaining = 10
    }
    
    func getRandomQuestion() -> Question? {
        return questions.randomElement()
    }
    
    func getRandomPunishment() -> String? {
        return punishments.randomElement()
    }
    
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            delegate?.timerDidUpdate(secondsRemaining: secondsRemaining)
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            gameState = .finished
            delegate?.gameDidEnd()
        }
    }
}
