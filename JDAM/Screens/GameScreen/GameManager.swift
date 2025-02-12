//
//  GameManager.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import Foundation

protocol GameManagerDelegate: AnyObject {
    func updateTimerLabel(_ secondsRemaining: Int)
    func gameDidFinish()
}

class GameManager {
    weak var delegate: GameManagerDelegate?
    
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
    
    func startGame() {
        secondsRemaining = 10
        delegate?.updateTimerLabel(secondsRemaining)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            delegate?.updateTimerLabel(secondsRemaining)
        } else {
            countdownTimer?.invalidate()
            delegate?.gameDidFinish()
        }
    }
}
