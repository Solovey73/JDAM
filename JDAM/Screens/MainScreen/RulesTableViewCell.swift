//
//  RulesTableViewCell.swift
//  JDAM
//
//  Created by Кирилл Бахаровский on 2/12/25.
//


import UIKit

class RulesTableViewCell: UITableViewCell {
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 29/2
        label.layer.masksToBounds = true
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Текст"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт игры", for: .normal)
        button.backgroundColor = UIColor(named: "backgroundButton")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.08
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 12
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func configure(_ firstText: String, _ secondText: String) {
        firstLabel.text = firstText
        secondLabel.text = secondText
        
        fillText(text: secondText, fillText: "“С Заданиями”")
        let isThirdCell = (firstText == "2")
        startButton.isHidden = !isThirdCell
        startButton.heightAnchor.constraint(equalToConstant: isThirdCell ? 28 : 0).isActive = true
        
        if (firstText == "2") {
            secondLabel.textAlignment = .center
        } else {
            secondLabel.textAlignment = .left
        }
    }
    
    private func fillText(text: String, fillText: String) {
        let attributedString = NSMutableAttributedString(string: text)
        
        if let range = text.range(of: fillText) {
            let nsRange = NSRange(range, in: text)
            
            attributedString.addAttribute(.foregroundColor, value: UIColor(red: 129/255, green: 48/255, blue: 167/255, alpha: 1), range: nsRange)
        }
        secondLabel.attributedText = attributedString
    }
}

extension RulesTableViewCell {
    private func setupViews(){
        [firstLabel, secondLabel, startButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            firstLabel.heightAnchor.constraint(equalToConstant: 29),
            firstLabel.widthAnchor.constraint(equalToConstant: 29)
        ])
        
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: 10),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 10),
            startButton.centerXAnchor.constraint(equalTo: secondLabel.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            startButton.widthAnchor.constraint(equalToConstant: 167),
//            startButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
    }
}
