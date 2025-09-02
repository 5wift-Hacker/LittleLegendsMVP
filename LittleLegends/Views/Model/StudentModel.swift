//
//  StudentModel.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import Foundation
import SwiftData


//model of the student
@Model
class Students {
    //creating a unique ID for the student
    @Attribute(.unique) var id: String
    
    //students name
    var name: String
    
    //student answers
    @Relationship(deleteRule: .cascade) var responses: [Responses]
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.responses = []
    }
}

//model of the students response
@Model
class Responses {
    //which student answered
    var studentID: String
    
    //question identification
    var questionID: String
    
    //which emotion was picked
    var chosenEmotion: ChosenEmotion
    
    //is it correct?
    var isCorrect: Bool
    
    init(studentID: String, questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool) {
        self.studentID = studentID
        self.questionID = questionID
        self.chosenEmotion = chosenEmotion
        self.isCorrect = isCorrect
    }
}

//CA = correct answer IA = incorrect answer
//all ash answers
enum ChosenEmotion: String, Codable {
    case q1CA, q1IA2, q2CA, q1IA1, q2IA1, q2IA2, q3IA1, q3IA2, q3CA, q5CA, q5IA1, q5IA2, q6CA, q6IA1, q6IA2
    
    var emoji: String {
            switch self {
            case .q1CA: return "Responsible and sorry"
            case .q1IA2: return "Excited to play with the pieces"
            case .q2CA: return "Frustrated"
            case .q1IA1: return "Proud of himself"
            case .q2IA1: return "Silly"
            case .q2IA2: return "Relaxed"
                
                //resuse q3 for q4
            case .q3IA1: return "He feels calm and proud"
            case .q3IA2: return "He feels sleepy and quiet"
            case .q3CA: return "His anger and embarrassment grow"
                
            case .q5CA: return "He feels angry and blames them"
            case .q5IA1: return "He wants to play hide and seek"
            case .q5IA2: return "He thinks they are cheering for him"
                
            case .q6CA: return "Angry and upset with himself"
            case .q6IA1: return "He is confident and happy"
            case .q6IA2: return "Hungry and tired"
            }
        }
}
