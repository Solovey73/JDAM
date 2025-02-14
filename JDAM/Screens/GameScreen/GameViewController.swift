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
        
        let pauseImage = UIImage(systemName: "pause.circle")
        let grayPauseImage = pauseImage?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let rightButton = UIBarButtonItem(
            image: grayPauseImage,
            style: .plain,
            target: self,
            action: #selector(pauseButtonTapped)
        )
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func pauseButtonTapped() {
        print("Кнопка справа была нажата!")
    }

}
