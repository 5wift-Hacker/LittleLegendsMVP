//
//  ClassInsightsView.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import SwiftUI

/*
 tab 1: classroom insights - display average & list of all questions and total amount correct
 */

struct ClassInsightsView: View {
    
    let questions: [MockQuestions] = mockQuestions
    let responses: [Responses] = mockResponses
    @State private var selectedQuestionID: String?
    
    var body: some View {
        
        ScrollView {
            VStack {
                //total correctt answwers
                let totalCorrect = responses.filter { $0.isCorrect }.count
                Text("Total Correct Answers \(totalCorrect) / \(responses.count)")
                    .font(.headline)
                    .foregroundStyle(.text)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                //class wide average for comic 1
                let classAverage = classAverageForComic(comicID: "c1")
                VStack {
                    Text("Class Average for Comic 1")
                        .font(.title)
                        .foregroundStyle(.text)
                        .padding(.bottom, 20)
                        
                    CircularProgressView(percentage: classAverage)
                        
                    Text("\(classAverage, specifier: "%.0f")% Correct")
                        .foregroundStyle(.text)
                        .font(.title2)
                        .padding()
                        .bold()
                }
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom)
            
            VStack (alignment: .leading, spacing: 15){
                ForEach(questions) { question in
                    NavigationLink {
                        QuestionInsightsView(students: mockStudents, responses: responses, questions: question)
                    } label: {
                        QuestionAnswerBlock(question: question, responses: responses)
                            .foregroundStyle(.text)
                        
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.background)
    }
    
    func classAverageForComic(comicID: String) -> Double {
        let comicQuestions = questions.filter { $0.questionID.hasPrefix("\(comicID)_") }
        let comicResponses = responses.filter { response in
            comicQuestions.contains { $0.questionID == response.questionID }
        }
        guard !comicResponses.isEmpty else { return 0.0 }
        let correctCount = comicResponses.filter {$0.isCorrect}.count
        return Double(correctCount) / Double(comicResponses.count) * 100.0
    }
}

#Preview {
    ClassInsightsView()
}
