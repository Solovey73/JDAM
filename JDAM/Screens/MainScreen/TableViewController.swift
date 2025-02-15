//
//  TableViewController.swift
//  JDAM
//
//  Created by Кирилл Бахаровский on 2/12/25.
//


import UIKit

class TableViewController: UIViewController {
    
    var rules: [String] = [
        "Все игроки становятся в круг.",
        "Первый игрок берет телефон и нажимает кнопку:",
        "На экране появляется вопрос 'Назовите фрукт'.",
        "Игрок отвечает на вопрос и после правильного ответа передает телефон следующему игроку.",
        "Игроки по кругу отвечают на один и тот же вопрос до тех пор, пока не взорвется бомба.",
        "Проигравшим считается тот, в чьих руках взорвалась бомба.",
        "Если выбран режим игры “С Заданиями”, то проигравший выполняет задание."
    ]
    
    
    private let idTableViewCell = "rulesTableViewCell"
    
    private let rulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupViews()
        setConstraints()
        setDelegate()
        
        rulesTableView.register(RulesTableViewCell.self, forCellReuseIdentifier: "RulesCell")
        rulesTableView.register(SpecialRulesTableViewCell.self, forCellReuseIdentifier: "SpecialRulesCell")

    }
    
    private func setDelegate() {
        rulesTableView.dataSource = self
        rulesTableView.delegate = self
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row == 2 - 1 ? "SpecialRulesCell" : "RulesCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if let specialCell = cell as? SpecialRulesTableViewCell, indexPath.row == 2 - 1 {
            specialCell.configure("2", "Первый игрок берет телефон и", "нажимает кнопку:")
            return specialCell
        } else if let rulesCell = cell as? RulesTableViewCell {
            rulesCell.configure(String(indexPath.row + 1), rules[indexPath.row])
            return rulesCell
        }

        return UITableViewCell()
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


extension TableViewController {
    private func setupViews() {
        [rulesTableView].forEach { localView in
            view.addSubview(localView)
            localView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            rulesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            rulesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rulesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rulesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
