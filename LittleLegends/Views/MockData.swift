//
//  MockQuestions.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import Foundation

// Points system configuration
let pointsPerCorrectAnswer: Int = 200

// Computes total points for a given student based on correct responses.
func pointsForStudent(_ studentID: String, from responses: [Responses]) -> Int {
    let correctCount = responses.filter { $0.studentID == studentID && $0.isCorrect }.count
    return correctCount * pointsPerCorrectAnswer
}

struct MockQuestions: Identifiable {
    var id: String { questionID }
    var questionID: String
    var questionText: String
    var correctEmotion: ChosenEmotion
    var answerOptions: [ChosenEmotion]
}

let mockQuestions: [MockQuestions] = [
    MockQuestions(questionID: "c1_p1", questionText: "How do you think Ash feels after breaking the gnomes' bridge?", correctEmotion: .q1CA, answerOptions: [.q1IA1, .q1IA2, .q1CA]),
    MockQuestions(questionID: "c1_p2", questionText: "Ash is having trouble fixing the bridge. What emotion is he starting to feel?", correctEmotion: .q2CA, answerOptions: [.q2IA1, .q2IA2, .q2CA]),
    MockQuestions(questionID: "c1_p3", questionText: "What is happening to Ash's emotions when everyone stares at him?", correctEmotion: .q3CA, answerOptions: [.q3CA, .q3IA1, .q3IA2]),
    MockQuestions(questionID: "c1_p4", questionText: "What is happening to Ash's emotions when everyone stares at him?", correctEmotion: .q3CA, answerOptions: [.q3IA1, .q3IA2, .q3CA]),
    MockQuestions(questionID: "c1_p5", questionText: "Why does Ash shout at the gnomes and run away?", correctEmotion: .q5CA, answerOptions: [.q5IA1, .q5CA, .q5IA2]),
    MockQuestions(questionID: "c1_p6", questionText: "How is Ash feeling when he yells alone in the snow?", correctEmotion: .q6CA, answerOptions: [.q6IA2, .q6IA1, .q6CA]),
]

let mockStudents: [Students] = [
    Students(id: UUID().uuidString, name: "John"),
    Students(id: UUID().uuidString, name: "Jane"),
    Students(id: UUID().uuidString, name: "Bob"),
    Students(id: UUID().uuidString, name: "Aaron"),
    Students(id: UUID().uuidString, name: "Sam"),
    Students(id: UUID().uuidString, name: "Chris"),
    Students(id: UUID().uuidString, name: "Alex"),
    Students(id: UUID().uuidString, name: "Ned"),
]

let mockResponses: [Responses] = [
    Responses(studentID: mockStudents[0].id, questionID: "c1_p1", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p1", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p1", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p1", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p1", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p1", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p1", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p1", chosenEmotion: .q1IA2, isCorrect: true),
    
    Responses(studentID: mockStudents[0].id, questionID: "c1_p2", chosenEmotion: .q1IA1, isCorrect: false),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p2", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p2", chosenEmotion: .q3IA2, isCorrect: false),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p2", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p2", chosenEmotion: .q1IA2, isCorrect: false),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p2", chosenEmotion: .q1CA, isCorrect: false),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p2", chosenEmotion: .q1IA1, isCorrect: false),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p2", chosenEmotion: .q1IA2, isCorrect: false),
    
    Responses(studentID: mockStudents[0].id, questionID: "c1_p3", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p3", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p3", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p3", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p3", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p3", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p3", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p3", chosenEmotion: .q1IA2, isCorrect: false),
    
    Responses(studentID: mockStudents[0].id, questionID: "c1_p4", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p4", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p4", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p4", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p4", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p4", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p4", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p4", chosenEmotion: .q1IA2, isCorrect: false),
    
    Responses(studentID: mockStudents[0].id, questionID: "c1_p5", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p5", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p5", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p5", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p5", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p5", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p5", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p5", chosenEmotion: .q1IA2, isCorrect: false),
    
    Responses(studentID: mockStudents[0].id, questionID: "c1_p6", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[1].id, questionID: "c1_p6", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[2].id, questionID: "c1_p6", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[3].id, questionID: "c1_p6", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[4].id, questionID: "c1_p6", chosenEmotion: .q1IA2, isCorrect: true),
    Responses(studentID: mockStudents[5].id, questionID: "c1_p6", chosenEmotion: .q1CA, isCorrect: true),
    Responses(studentID: mockStudents[6].id, questionID: "c1_p6", chosenEmotion: .q1IA1, isCorrect: true),
    Responses(studentID: mockStudents[7].id, questionID: "c1_p6", chosenEmotion: .q1IA2, isCorrect: false),
    
]
