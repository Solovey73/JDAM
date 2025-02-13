//
//  SettingsViewController.swift
//  JDAM
//
//  Created by Victor Garitskyu on 13.02.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = Colors.textPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navigationDivider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textPrimary
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameTimeContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.categoryCellBg
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.textPrimary.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ ИГРЫ"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeButtonsHorizontalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 44
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeButtonsHorizontalStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 44
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let soundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.categoryCellBg
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.textPrimary.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let soundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let toggleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.categoryCellBg
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.textPrimary.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toggleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var isVibrationEnabled: Bool {
            get { UserDefaults.standard.bool(forKey: "isVibrationEnabled") }
            set { UserDefaults.standard.set(newValue, forKey: "isVibrationEnabled") }
        }
    
     private let soundOptions = [
         "background": ["Мелодия 1", "Мелодия 2", "Мелодия 3"],
         "ticking": ["Часы 1", "Часы 2", "Часы 3"],
         "explosion": ["Взрыв 1", "Взрыв 2", "Взрыв 3"]
     ]
     
     private var selectedSounds: [String: String] {
         get {
             let defaults = UserDefaults.standard
             return [
                 "background": defaults.string(forKey: "selectedBackgroundSound") ?? "Мелодия 1",
                 "ticking": defaults.string(forKey: "selectedTickingSound") ?? "Часы 1",
                 "explosion": defaults.string(forKey: "selectedExplosionSound") ?? "Взрыв 1"
             ]
         }
         set {
             let defaults = UserDefaults.standard
             defaults.set(newValue["background"], forKey: "selectedBackgroundSound")
             defaults.set(newValue["ticking"], forKey: "selectedTickingSound")
             defaults.set(newValue["explosion"], forKey: "selectedExplosionSound")
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Colors.mainSheetBg
        setBackgroundImage(imageName: "Topographic 4", alpha: 1)
        
        // Add subviews
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(navigationDivider)
        view.addSubview(gameTimeContainer)
        
        view.addSubview(soundContainer)
        soundContainer.addSubview(soundStackView)
        
        view.addSubview(toggleContainer)
        toggleContainer.addSubview(toggleStackView)
        
        gameTimeContainer.addSubview(gameTimeLabel)
        gameTimeContainer.addSubview(timeButtonsStackView)
        
        timeButtonsStackView.addArrangedSubview(timeButtonsHorizontalStackView1)
        timeButtonsStackView.addArrangedSubview(timeButtonsHorizontalStackView2)
        
        // Create time buttons
        let shortButton = createTimeButton(with: "Короткое")
        let mediumButton = createTimeButton(with: "Среднее")
        let longButton = createTimeButton(with: "Длинное")
        let randomButton = createTimeButton(with: "Случайное")
        
        timeButtonsHorizontalStackView1.addArrangedSubview(shortButton)
        timeButtonsHorizontalStackView1.addArrangedSubview(mediumButton)
        timeButtonsHorizontalStackView2.addArrangedSubview(longButton)
        timeButtonsHorizontalStackView2.addArrangedSubview(randomButton)
        
        // Create sound buttons
        soundStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            let backgroundMusicButton = createSoundButton(with: "Фоновая музыка", subtitle: selectedSounds["background"] ?? "Мелодия 1")
            let tickingButton = createSoundButton(with: "Тиканье бомбы", subtitle: selectedSounds["ticking"] ?? "Часы 1")
            let explosionButton = createSoundButton(with: "Взрыв бомбы", subtitle: selectedSounds["explosion"] ?? "Взрыв 1")
            
            soundStackView.addArrangedSubview(backgroundMusicButton)
            soundStackView.addArrangedSubview(tickingButton)
            soundStackView.addArrangedSubview(explosionButton)
        
        // Create toggle rows
        let vibrationRow = createToggleRow(title: "Вибрация")
        let taskGameRow = createToggleRow(title: "Игра с заданиями")
        
        toggleStackView.addArrangedSubview(vibrationRow)
        toggleStackView.addArrangedSubview(taskGameRow)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 23),
            backButton.heightAnchor.constraint(equalToConstant: 58),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            navigationDivider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            navigationDivider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            navigationDivider.heightAnchor.constraint(equalToConstant: 5),
            navigationDivider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gameTimeContainer.topAnchor.constraint(equalTo: navigationDivider.bottomAnchor, constant: 10),
            gameTimeContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            gameTimeContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            gameTimeLabel.topAnchor.constraint(equalTo: gameTimeContainer.topAnchor, constant: 16),
            gameTimeLabel.leadingAnchor.constraint(equalTo: gameTimeContainer.leadingAnchor, constant: 24),
            
            timeButtonsStackView.topAnchor.constraint(equalTo: gameTimeLabel.bottomAnchor, constant: 18),
            timeButtonsStackView.leadingAnchor.constraint(equalTo: gameTimeContainer.leadingAnchor, constant: 24),
            timeButtonsStackView.trailingAnchor.constraint(equalTo: gameTimeContainer.trailingAnchor, constant: -24),
            timeButtonsStackView.bottomAnchor.constraint(equalTo: gameTimeContainer.bottomAnchor, constant: -24),
            
            soundContainer.topAnchor.constraint(equalTo: gameTimeContainer.bottomAnchor, constant: 16),
            soundContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            soundContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            soundStackView.topAnchor.constraint(equalTo: soundContainer.topAnchor, constant: 24),
            soundStackView.leadingAnchor.constraint(equalTo: soundContainer.leadingAnchor, constant: 24),
            soundStackView.trailingAnchor.constraint(equalTo: soundContainer.trailingAnchor, constant: -24),
            soundStackView.bottomAnchor.constraint(equalTo: soundContainer.bottomAnchor, constant: -24),
            
            toggleContainer.topAnchor.constraint(equalTo: soundContainer.bottomAnchor, constant: 16),
            toggleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            toggleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            toggleStackView.topAnchor.constraint(equalTo: toggleContainer.topAnchor, constant: 24),
            toggleStackView.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor, constant: 24),
            toggleStackView.trailingAnchor.constraint(equalTo: toggleContainer.trailingAnchor, constant: -24),
            toggleStackView.bottomAnchor.constraint(equalTo: toggleContainer.bottomAnchor, constant: -24)
        ])
    }
    
    private func createTimeButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.textPrimary
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        return button
    }

    private func createSoundButton(with title: String, subtitle: String) -> UIButton {
            let button = UIButton()
            button.backgroundColor = Colors.textPrimary
            button.layer.cornerRadius = 15
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(stackView)
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = .white
            titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
            
            let subtitleLabel = UILabel()
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = .lightGray
            subtitleLabel.font = .systemFont(ofSize: 16)
            
            let chevronImage = UIImageView(image: UIImage(systemName: "chevron.right"))
            chevronImage.tintColor = .lightGray
            
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(UIView())
            stackView.addArrangedSubview(subtitleLabel)
            stackView.addArrangedSubview(chevronImage)
            
            switch title {
            case "Фоновая музыка":
                button.addTarget(self, action: #selector(backgroundMusicTapped), for: .touchUpInside)
            case "Тиканье бомбы":
                button.addTarget(self, action: #selector(tickingSoundTapped), for: .touchUpInside)
            case "Взрыв бомбы":
                button.addTarget(self, action: #selector(explosionSoundTapped), for: .touchUpInside)
            default:
                break
            }
            
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20),
                stackView.topAnchor.constraint(equalTo: button.topAnchor, constant: 15),
                stackView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -15)
            ])
            
            return button
        }
    
    @objc private func backgroundMusicTapped() {
         showSoundOptions(for: "background", title: "Фоновая музыка")
     }
     
     @objc private func tickingSoundTapped() {
         showSoundOptions(for: "ticking", title: "Тиканье бомбы")
     }
     
     @objc private func explosionSoundTapped() {
         showSoundOptions(for: "explosion", title: "Взрыв бомбы")
     }
     
     private func showSoundOptions(for type: String, title: String) {
         let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
         
         soundOptions[type]?.forEach { option in
             let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
                 var currentSounds = self?.selectedSounds ?? [:]
                 currentSounds[type] = option
                 self?.selectedSounds = currentSounds
                 self?.updateSoundButtons()
             }
             alert.addAction(action)
         }
         
         let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
         alert.addAction(cancelAction)
         
         present(alert, animated: true)
     }
     
     private func updateSoundButtons() {
         // Remove existing buttons
         soundStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
         
         // Recreate sound buttons with updated subtitles
         let backgroundMusicButton = createSoundButton(with: "Фоновая музыка", subtitle: selectedSounds["background"] ?? "Мелодия 1")
         let tickingButton = createSoundButton(with: "Тиканье бомбы", subtitle: selectedSounds["ticking"] ?? "Часы 1")
         let explosionButton = createSoundButton(with: "Взрыв бомбы", subtitle: selectedSounds["explosion"] ?? "Взрыв 1")
         
         soundStackView.addArrangedSubview(backgroundMusicButton)
         soundStackView.addArrangedSubview(tickingButton)
         soundStackView.addArrangedSubview(explosionButton)
     }
     
    



    private func createToggleRow(title: String) -> UIView {
          let container = UIView()
          container.backgroundColor = Colors.textPrimary
          container.layer.cornerRadius = 20
          
          let titleLabel = UILabel()
          titleLabel.text = title
          titleLabel.textColor = .white
          titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          
          let toggle = UISwitch()
          toggle.onTintColor = Colors.categorySheetBg
          toggle.translatesAutoresizingMaskIntoConstraints = false
          
          // Set initial state for vibration toggle
          if title == "Вибрация" {
              toggle.isOn = isVibrationEnabled
              toggle.addTarget(self, action: #selector(vibrationToggled(_:)), for: .valueChanged)
          }
          
          container.addSubview(titleLabel)
          container.addSubview(toggle)
          
          NSLayoutConstraint.activate([
              titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
              titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
              
              toggle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
              toggle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
              
              container.heightAnchor.constraint(equalToConstant: 60)
          ])
          
          return container
      }
    
    @objc private func vibrationToggled(_ sender: UISwitch) {
         isVibrationEnabled = sender.isOn
         if sender.isOn {
             let feedback = UIImpactFeedbackGenerator(style: .medium)
             feedback.prepare()
             feedback.impactOccurred()
         }
     }
}



#Preview {
    let vc = SettingsViewController()
    
    return vc
}
