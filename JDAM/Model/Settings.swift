//
//  Settings.swift
//  JDAM
//
//  Created by Dmitry Volkov on 15/02/2025.
//

import Foundation

struct Settings: Codable {
    var categories: [QuestionCategory]
    var time: Int
    var backgroundMusic: String
    var bombTicking: String
    var bombExplosion: String
    var isVibrated: Bool = false
    var isTasksMode: Bool = false
}
