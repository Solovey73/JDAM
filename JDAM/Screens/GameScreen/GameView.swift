//
//  GameView.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import UIKit
import Lottie


class GameView: UIView {
    // MARK: - UI
    
    lazy var bombAnimationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var explosionAnimationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var timerLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.textAlignment = .center
            label.text = "10"
            label.textColor = .white
            label.isHidden = true
            return label
        }()
    
    lazy var punismentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  Punisment().data.randomElement()
        label.font = .sFProRoundedFont(ofSize: 28, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .sFProRoundedFont(ofSize: 20, weight: .semiBold)
        button.setTitle("Запустить", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        return button
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .sFProRoundedFont(ofSize: 20, weight: .semiBold)
        button.setTitle("Начать заново", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        return button
    }()
    
    lazy var newTaskButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .sFProRoundedFont(ofSize: 20, weight: .semiBold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Другое задание", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        return button
    }()
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setBackground()
        setAnimation()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        [
            titleLabel,
            startButton,
            bombAnimationView,
            timerLabel,
            restartButton,
            newTaskButton,
            punismentLabel,
            explosionAnimationView
        ].forEach { addSubview($0) }
    }
    
}


// MARK: - Set BG and Constraints

private extension GameView {
    func setBackground() {
        backgroundColor = UIColor(named: "bgColor")
        layer.contents = UIImage(named: "bgPattern")?.cgImage
        layer.contentsGravity = .resizeAspectFill
    }
    
    func setAnimation() {
        bombAnimationView.animation = LottieAnimation.named("bombAnimation")
        bombAnimationView.loopMode = .loop
        
        explosionAnimationView.animation = LottieAnimation.named("explosionAnimation")
        explosionAnimationView.loopMode = .playOnce
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            explosionAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            explosionAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            explosionAnimationView.widthAnchor.constraint(equalToConstant: 300),
            explosionAnimationView.heightAnchor.constraint(equalToConstant: 300),
            punismentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            punismentLabel.topAnchor.constraint(equalTo: explosionAnimationView.bottomAnchor, constant: 50),
            punismentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            punismentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            restartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            restartButton.widthAnchor.constraint(equalToConstant: 300),
            newTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            newTaskButton.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -15),
            newTaskButton.heightAnchor.constraint(equalToConstant: 50),
            newTaskButton.widthAnchor.constraint(equalToConstant: 300),
            bombAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 30),
            bombAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            bombAnimationView.widthAnchor.constraint(equalToConstant: 300),
            bombAnimationView.heightAnchor.constraint(equalToConstant: 300),
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40),
            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
