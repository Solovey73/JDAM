//
//  RulesViewController.swift
//  JDAM
//
//  Created by Кирилл Бахаровский on 2/12/25.
//


import UIKit

protocol RulesViewControllerDelegate: AnyObject {
    func rulesViewControllerDidDismiss()
}

class RulesViewController: UIViewController {

    weak var delegate: RulesViewControllerDelegate?
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Правила игры"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private let tableView = TableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setBackground()
        setConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           delegate?.rulesViewControllerDidDismiss()
       }
    
    @objc private func handleTapOutside(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
            if !containerView.frame.contains(location) {
                dismiss(animated: true, completion: nil)
            }
    }
}

extension RulesViewController {
    private func setBackground() {
        containerView.backgroundColor = UIColor(named: "bgColor")
        containerView.layer.contents = UIImage(named: "backgroundRules")?.cgImage
        containerView.layer.contentsGravity = .resizeAspectFill
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, line].forEach() {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addChild(tableView)
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView.view)
        tableView.didMove(toParent: self)
        
        configure()
    }
    
    private func configure() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            line.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            line.widthAnchor.constraint(equalToConstant: 68),
            line.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 650)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            tableView.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            tableView.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            tableView.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -23),
        ])
    }
}

