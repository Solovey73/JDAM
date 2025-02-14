//
//  GameView.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import UIKit


class GameView: UIView {
    // MARK: - UI
    
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
            label.isHidden = true
            return label
        }()
    
    lazy var punismentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  Punisment().data.randomElement()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bombImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "bomb")
        return view
    }()
    
    lazy var explosionImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "explosion")
        return view
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запустить", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать заново", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var newTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Другое задание", for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setBackground()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        [
            titleLabel,
            bombImage,
            explosionImage,
            startButton,
            timerLabel,
            restartButton,
            newTaskButton,
            punismentLabel
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
