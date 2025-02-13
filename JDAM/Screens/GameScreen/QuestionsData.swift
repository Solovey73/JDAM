//
//  QuestionsData.swift
//  JDAM
//
//  Created by Dmitry Volkov on 11/02/2025.
//

import Foundation

enum QuestionCategory: String {
    case other = "О Разном"
    case live = "Про жизнь"
}

struct Question {
    let question: String
    let categoty: QuestionCategory
}

struct QuestionsData {
    var data = [
        Question(question: "Сколько дней в году?", categoty: .live),
        Question(question: "Что пьет корова?", categoty: .live),
        Question(question: "Где восходит солнце?", categoty: .live),
        Question(question: "В честь кого назван мишка Teddy?", categoty: .live),
        Question(question: "Что такое валентность?", categoty: .live),
    ]
}
