//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Mikolaj Lukasik on 27/08/2019.
//  Copyright © 2019 Mikolaj Lukasik. All rights reserved.
//

import Foundation

enum ResponseType {
    case single, multiple, ranged
}

enum HogwartsHouse: Character{
    case gryffindor = "🦁", hufflepuff = "🦡", ravenclaw = "🦅", slytherin = "🐍"
    
    var definition: String {
        switch self {
        case .gryffindor:
            return "Gryffindor values courage, bravery, nerve and chivalry."
        case .hufflepuff:
            return "Hufflepuff values hard work, patience, justice, and loyalty."
        case .ravenclaw:
            return "Ravenclaw values intelligence, creativity, learning, and wit."
        case .slytherin:
            return "Slytherin house values ambition, cunning, leadership, and resourcefulness."
        }
    }
}

struct Answer {
    var text: String
    var type: HogwartsHouse
}

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}
