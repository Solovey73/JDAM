//
//  StorageManager.swift
//  JDAM
//
//  Created by Dmitry Volkov on 15/02/2025.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys: String {
            case settings = "settings"
    }

    private init() {}
    
    func saveSettings(_ settings: Settings) {
        if let encoded = try? JSONEncoder().encode(settings) {
            defaults.set(encoded, forKey: Keys.settings.rawValue)
        }
    }
        
    func getSettings() -> Settings? {
        if let data = defaults.data(forKey: Keys.settings.rawValue),
            let decoded = try? JSONDecoder().decode(Settings.self, from: data) {
            return decoded
        }
        return nil
    }
    
    
    func addCategory(_ category: QuestionCategory) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        if !currentSettings.categories.contains(category) {
            currentSettings.categories.append(category)
            saveSettings(currentSettings)
        }
    }
    
    func removeCategory(_ category: QuestionCategory) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.categories.removeAll { $0 == category }
        saveSettings(currentSettings)
    }
    
    func updateTime(_ time: Int) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.time = time
        saveSettings(currentSettings)
    }
        
    func updateBackgroundMusic(_ backgroundMusic: String) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.backgroundMusic = backgroundMusic
        saveSettings(currentSettings)
    }
    
    func updateBombTicking(_ bombTicking: String) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.bombTicking = bombTicking
        saveSettings(currentSettings)
    }
        
    func updateBombExplosion(_ bombExplosion: String) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.bombExplosion = bombExplosion
        saveSettings(currentSettings)
    }
    
    func updateIsVibrated(_ isVibrated: Bool) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.isVibrated = isVibrated
        saveSettings(currentSettings)
    }
        
    func updateIsTasksMode(_ isTasksMode: Bool) {
        var currentSettings = getSettings() ?? Settings(
            categories: [],
            time: 30,
            backgroundMusic: "default_music",
            bombTicking: "default_ticking",
            bombExplosion: "default_explosion"
        )
        currentSettings.isTasksMode = isTasksMode
        saveSettings(currentSettings)
    }
    
}


//StorageManager.shared.addCategory(.science)
