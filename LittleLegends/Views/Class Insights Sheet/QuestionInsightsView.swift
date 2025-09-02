//
//  QuestionInsightsView.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import SwiftUI

struct QuestionInsightsView: View {
    
    let students: [Students]
    let responses: [Responses]
    let questions: MockQuestions
    
    var body: some View {
        
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                
                VStack {
                    Text("Q: \(questions.questionText)")
                        .foregroundStyle(.text)
                        .font(.title3)
                        .bold()
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThickMaterial).ignoresSafeArea()
                
                VStack {
                    ForEach(responses.filter { $0.questionID == questions.questionID }) { response in
                        if let student = students.first(where: { $0.id == response.studentID }) {
                            HStack {
                                Text(student.name)
                                    .font(.headline)
                                    .foregroundStyle(.text)
                                Spacer()
                                Text(response.chosenEmotion.rawValue.capitalized)
                                    .foregroundStyle(response.isCorrect ? .green : .red)
                                Image(systemName: response.isCorrect ? "checkmark.circle" : "xmark.circle")
                                    .foregroundStyle(response.isCorrect ? .green : .red)
                            }
                            .padding(25)
                            .padding(.horizontal, 50)
                            .background(in: RoundedRectangle(cornerRadius: 15))
                            .padding(.horizontal, 100)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    
    let response = mockResponses
    let questions = mockQuestions
    let students = mockStudents
    
    NavigationStack {
        QuestionInsightsView(students: students, responses: response, questions: questions[0])
    }
}
