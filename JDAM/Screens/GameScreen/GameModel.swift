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
    var isTimerPaused: Bool = false
    
    init(questions: [Question], punishments: [String]) {
        self.questions = questions
        self.punishments = punishments
        self.secondsRemaining = StorageManager.shared.getSettings()?.time ?? 60
    }
    
    func startGame() {
        gameState = .inProgress
        secondsRemaining = StorageManager.shared.getSettings()?.time ?? 60
        startTimer()
    }
    
    func restartGame() {
        gameState = .start
        secondsRemaining = StorageManager.shared.getSettings()?.time ?? 60
        countdownTimer?.invalidate() // Останавливаем текущий таймер
        countdownTimer = nil
        isTimerPaused = false // Сбрасываем флаг паузы
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
    
    func pauseTimer() {
        isTimerPaused = true
        countdownTimer?.invalidate() // Останавливаем таймер
        countdownTimer = nil // Убираем ссылку на таймер
    }
        
    func resumeTimer() {
        isTimerPaused = false
        startTimer() // Запускаем таймер снова
    }
    
    @objc private func updateTimer() {
        if isTimerPaused {
            return // Если таймер на паузе, ничего не делаем
        }
        
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
