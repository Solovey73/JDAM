//
//  CategoryRulesViewController.swift
//  JDAM
//
//  Created by Вячеслав on 15.02.2025.
//

import UIKit

class CategoryRulesViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: Int(UIScreen.main.bounds.height * 0.10),
                            width: Int(UIScreen.main.bounds.width),
                            height: Int(UIScreen.main.bounds.height * 0.80))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        setBackground()
    }
    
    private func setBackground() {
        containerView.backgroundColor = UIColor(named: "bgColor")
        containerView.layer.contents = UIImage(named: "ПравилаКатегории")?.cgImage
        containerView.layer.contentsGravity = .resizeAspectFill
    }
}
