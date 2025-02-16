//
//  GameViewController.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import UIKit

enum GameState {
    case start
    case inProgress
    case finished
}

class GameViewController: UIViewController, GameModelDelegate {
    // MARK: - Properties
    private let gameView = GameView()
    private let gameModel: GameModel
    
    // MARK: - Initialization
    init() {
        self.gameModel = GameModel(questions: QuestionsData().data, punishments: Punisment().data)
        super.init(nibName: nil, bundle: nil)
        self.gameModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupNavigationBar()
        updateUI()
    }
    
    // MARK: - Setup
    private func setupButtons() {
        gameView.startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        gameView.restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        gameView.newTaskButton.addTarget(self, action: #selector(newTask), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        let pauseImage = UIImage(systemName: "pause.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let rightButton = UIBarButtonItem(image: pauseImage, style: .plain, target: self, action: #selector(pauseButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupNavigationBarPlay() {
        let pauseImage = UIImage(systemName: "play.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let rightButton = UIBarButtonItem(image: pauseImage, style: .plain, target: self, action: #selector(pauseButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    
    // MARK: - Actions
    @objc private func startGame() {
        gameModel.startGame()
        updateUI()
    }
    
    @objc private func restartGame() {
        gameModel.restartGame()
        updateUI()
    }
    
    @objc private func newTask() {
        if let punishment = gameModel.getRandomPunishment() {
            gameView.punismentLabel.text = punishment
        }
    }
    
    @objc private func pauseButtonTapped() {
        if gameModel.isTimerPaused {
            gameView.bombAnimationView.play()
            gameModel.playMusic()
            gameModel.pauseTimer()
            setupNavigationBar()
            gameModel.isTimerPaused.toggle()
        } else {
            gameView.bombAnimationView.stop()
            gameModel.stopMusic()
            gameModel.resumeTimer()
            setupNavigationBarPlay()
            gameModel.isTimerPaused.toggle()
        }
        
        
    }
    
    // MARK: - Update UI
    func updateUI() {
        switch gameModel.gameState {
        case .start:
            gameView.titleLabel.text = "Нажмите \"запустить\", чтобы начать игру"
            gameView.titleLabel.font = .sFProRoundedFont(ofSize: 28, weight: .regular)
            gameView.titleLabel.isHidden = false
            gameView.timerLabel.isHidden = true
            gameView.startButton.isHidden = false
            gameView.restartButton.isHidden = true
            gameView.newTaskButton.isHidden = true
            gameView.punismentLabel.isHidden = true
            gameView.explosionAnimationView.isHidden = true
            gameView.bombAnimationView.isHidden = false
            navigationItem.rightBarButtonItem = nil
            gameView.bombAnimationView.stop()
            gameModel.stopMusic()
        case .inProgress:
            gameView.titleLabel.text = gameModel.getRandomQuestion()?.question
            gameView.titleLabel.font = .sFProRoundedFont(ofSize: 28, weight: .bold)
            gameView.startButton.isHidden = true
            gameView.timerLabel.isHidden = false
            gameView.timerLabel.text = "\(gameModel.secondsRemaining)"
            setupNavigationBar()
            
        
            
        case .finished:
            gameView.timerLabel.isHidden = true
            gameView.titleLabel.isHidden = true
            gameView.explosionAnimationView.isHidden = false
            gameView.restartButton.isHidden = false
            gameView.newTaskButton.isHidden = false
            gameView.punismentLabel.isHidden = false
            gameView.bombAnimationView.isHidden = true
            gameView.explosionAnimationView.loopMode = .playOnce
            if !gameView.explosionAnimationView.isAnimationPlaying {
                gameView.explosionAnimationView.play()
            }
            gameModel.stopMusic()
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    // MARK: - GameModelDelegate
        func timerDidUpdate(secondsRemaining: Int) {
            gameView.timerLabel.text = "\(secondsRemaining)"
        }
        
        func gameDidEnd() {
            updateUI()
        }
}
