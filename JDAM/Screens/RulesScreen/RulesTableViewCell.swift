//
//  RulesTableViewCell.swift
//  JDAM
//
//  Created by Кирилл Бахаровский on 2/12/25.
//


import UIKit

class RulesTableViewCell: UITableViewCell {
    
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
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Текст"
        label.font = .sFProRoundedFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
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
        numberLabel.text = firstText
        secondLabel.text = secondText
        
        fillText(text: secondText, fillText: "“С Заданиями”")
        
        if numberLabel.text == "1" {
            secondLabel.font = .sFProRoundedFont(ofSize: 20, weight: .medium)
        } else {
            secondLabel.font = .sFProRoundedFont(ofSize: 18, weight: .medium)
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
        [cicleView, secondLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        cicleView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cicleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cicleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cicleView.heightAnchor.constraint(equalToConstant: 29),
            cicleView.widthAnchor.constraint(equalToConstant: 29)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: cicleView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: cicleView.centerYAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            secondLabel.leadingAnchor.constraint(equalTo: cicleView.trailingAnchor, constant: 10),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
