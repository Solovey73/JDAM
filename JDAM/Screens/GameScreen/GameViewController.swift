//
//  GameViewController.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    let gameView = GameView()
    
    //MARK: - Life cycle
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
