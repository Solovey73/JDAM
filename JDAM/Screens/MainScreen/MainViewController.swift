//
//  MainViewController.swift
//  JDAM
//
//  Created by Вячеслав on 10.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var titleFirst: UILabel = {
        let label = UILabel()
        label.text = "ИГРА ДЛЯ КОМПАНИИ"
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowRadius = 3
        return label
    }()
    
    private lazy var titleSecond: UILabel = {
        let label = UILabel()
        label.text = "БОМБА"
        label.font = UIFont.systemFont(ofSize: 48, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowRadius = 3
        return label
    }()
    
    private lazy var bombImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bombMain")
        return view
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт игры", for: .normal)
        button.backgroundColor = UIColor(named: "backgroundButton")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 6

        button.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        return button
    }()

    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Категории", for: .normal)
        button.backgroundColor = UIColor(named: "backgroundButton")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsNavigationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "mainLeftButton")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(settingsNavigationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rulesNavigationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "mainRightButton")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(rulesNavigationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupViews()
        setBackground()
        setupNavigationController()
        setConstraints()
    }
    
    @objc private func startGameButtonTapped() {
        print("startGameTapped")
    }
    
    @objc private func categoryButtonTapped() {
        print("categoryTapped")
    }
    
    @objc private func settingsNavigationButtonTapped() {
        print("settingsNavigationButton")
    }
    
    @objc private func rulesNavigationButtonTapped() {
        let vc = RulesViewController()
        vc.modalPresentationStyle = .popover
        vc.delegate = self
        navigationItem.leftBarButtonItem = nil
        present(vc, animated: true)
    }
    
}

extension MainViewController {
    private func setBackground() {
        view.backgroundColor = UIColor(named: "backgroundMainColor")
        view.layer.contents = UIImage(named: "Topographic 3")?.cgImage
        view.layer.contentsGravity = .resizeAspectFill
    }
    
    private func setupNavigationController() {
        let settingsButton = UIBarButtonItem(customView: settingsNavigationButton)
        navigationItem.leftBarButtonItem = settingsButton
        
        let rulesButton = UIBarButtonItem(customView: rulesNavigationButton)
        navigationItem.rightBarButtonItem = rulesButton
    }
    
    private func setupViews() {
        [titleFirst, titleSecond, bombImage, startButton, categoryButton].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleFirst.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            titleSecond.topAnchor.constraint(equalTo: titleFirst.bottomAnchor, constant: 0),
            titleSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            titleSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            bombImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bombImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            categoryButton.heightAnchor.constraint(equalToConstant: 73)
        ])
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: categoryButton.topAnchor, constant: -19),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            startButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
}

extension MainViewController: RulesViewControllerDelegate {
    func rulesViewControllerDidDismiss() {
        let settingsButton = UIBarButtonItem(customView: settingsNavigationButton)
        settingsNavigationButton.alpha = 0.0
        navigationItem.leftBarButtonItem = settingsButton
        
        UIView.animate(withDuration: 0.3) {
            self.settingsNavigationButton.alpha = 1.0
        }
    }
}
