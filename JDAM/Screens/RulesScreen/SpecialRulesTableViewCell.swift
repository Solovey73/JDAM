//
//  SpecialRulesTableViewCell.swift
//  JDAM
//
//  Created by Кирилл Бахаровский on 2/14/25.
//


import UIKit

class SpecialRulesTableViewCell: UITableViewCell {
    
    private lazy var cicleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 29/2
        view.layer.masksToBounds = false
        view.backgroundColor = .systemYellow
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 3
        
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .delaGothicOneFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Текст1"
        label.font = .sFProRoundedFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Текст2"
        label.font = .sFProRoundedFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт игры", for: .normal)
        button.backgroundColor = UIColor(named: "backgroundButton")
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .sFProRoundedFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
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
    
    
    func configure(_ numberText: String, _ firstText: String, _ secondText: String) {
        numberLabel.text = numberText
        firstLabel.text = firstText
        secondLabel.text = secondText
    }
}

extension SpecialRulesTableViewCell {
    private func setupViews(){
        [cicleView, firstLabel, secondLabel, startButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        cicleView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cicleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            cicleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cicleView.heightAnchor.constraint(equalToConstant: 29),
            cicleView.widthAnchor.constraint(equalToConstant: 29)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: cicleView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: cicleView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: cicleView.topAnchor, constant: 0),
            firstLabel.leadingAnchor.constraint(equalTo: cicleView.trailingAnchor, constant: 10),
            firstLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 0),
            secondLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 10),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 7),
            startButton.centerXAnchor.constraint(equalTo: secondLabel.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            startButton.widthAnchor.constraint(equalToConstant: 167),
            startButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
    }
}
