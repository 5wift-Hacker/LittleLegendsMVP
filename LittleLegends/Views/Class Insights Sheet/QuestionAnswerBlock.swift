//
//  QuestionAnswerBlock.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import SwiftUI

struct QuestionAnswerBlock: View {
    
    let question: MockQuestions
    let responses: [Responses]
    @State private var points: Double = 0.0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                    Spacer()
                    Text("Students")
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 10)
                }
                    Text("Q: \(question.questionText)")
                        .font(.title3)
            }
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 450, height: 50)
                    .foregroundStyle(.gray)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 450 * (points / 100), height: 50)
                    .foregroundStyle(.green)
                
                Text("Answered correctly: \(Int(points))%")
                    .font(.title3)
                    .foregroundStyle(.text)
                    .padding(.leading)
            }
        }
        .padding()
        //put geo frame in here for sizing perhaps?
        .frame(width: 500, height: 150)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            withAnimation {
                points = averageScore()
            }
        }
    }
    
    private func averageScore() -> Double {
            let questionResponses = responses.filter { $0.questionID == question.questionID }
            guard !questionResponses.isEmpty else { return 0.0 }
            let correctCount = questionResponses.filter { $0.isCorrect }.count
            return Double(correctCount) / Double(questionResponses.count) * 100
        }
    
}


#Preview {
    QuestionAnswerBlock(question: mockQuestions[0], responses: mockResponses)
        .preferredColorScheme(.light)
}
