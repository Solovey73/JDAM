//
//  GameView.swift
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


class GameView: UIView {
    private var questions = QuestionsData().data
    private var gameState: GameState = .start
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
    var imagePadding: CGFloat = 0
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var timerLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.textAlignment = .center
            label.text = "10"
            label.isHidden = true
            return label
        }()
    
    private lazy var punismentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  Punisment().data.randomElement()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bombImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "bomb")
        return view
    }()
    
    private lazy var explosionImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "explosion")
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запустить", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать заново", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(restartGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var newTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Другое задание", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(newTaskButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setBackground()
        setStateView()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(bombImage)
        addSubview(explosionImage)
        addSubview(startButton)
        addSubview(timerLabel)
        addSubview(restartButton)
        addSubview(newTaskButton)
        addSubview(punismentLabel)
    }
    
}


// MARK: - Set Constraints

private extension GameView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bombImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bombImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            explosionImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            explosionImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            punismentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            punismentLabel.topAnchor.constraint(equalTo: explosionImage.bottomAnchor, constant: 50),
            punismentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            punismentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            restartButton.widthAnchor.constraint(equalToConstant: 300),
            newTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            newTaskButton.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -15),
            newTaskButton.heightAnchor.constraint(equalToConstant: 50),
            newTaskButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

private extension GameView {
    func setBackground() {
        backgroundColor = UIColor(named: "bgColor")
        layer.contents = UIImage(named: "bgPattern")?.cgImage
        layer.contentsGravity = .resizeAspectFill
    }
    
    @objc func startGame() {
        startTimer()
        
        let chosenQuestion = questions.randomElement()
        titleLabel.text = chosenQuestion?.question
        
        gameState = .inProgress
        setStateView()
    }

    
    func setStateView() {
        switch gameState {
        case .start:
            titleLabel.text =  "Нажмите \"запустить\", чтобы начать игру"
            secondsRemaining = 10
            bombImage.image = UIImage(named: "bomb")
            titleLabel.isHidden = false
            bombImage.isHidden = false
            startButton.isHidden = false
            restartButton.isHidden = true
            newTaskButton.isHidden = true
            punismentLabel.isHidden = true
            explosionImage.isHidden = true
        case .inProgress:
            bombImage.isHidden = true
            startButton.isHidden = true
            timerLabel.isHidden = false
        case .finished:
            imagePadding = -150
            timerLabel.isHidden = true
            titleLabel.isHidden = true
            explosionImage.isHidden = false
            restartButton.isHidden = false
            newTaskButton.isHidden = false
            punismentLabel.isHidden = false
            bombImage.image = UIImage(named: "explosion")
        }
    }
}


// MARK: - Timer

private extension GameView {
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
        
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            timerLabel.text = "\(secondsRemaining)"
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            gameState = .finished
            setStateView()
        }
    }
}

// MARK: - Buttons actions

private extension GameView {
    @objc private func restartGameButtonTapped() {
        gameState = .start
        setStateView()
        print("DEBUG restartGameButtonTapped")
    }
    
    @objc private func newTaskButtonTapped() {
        punismentLabel.text = Punisment().data.randomElement()
        print("DEBUG newTaskButtonTapped")
    }
}
