//
//  StudentsView.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import SwiftUI

//need list of all students displayed

//view that passes in student and displays answers to last comic game played

//name of comic played

//when the session was played

struct StudentsView: View {
    
    var students = mockStudents
    let responses = mockResponses
    let questions = mockQuestions
    
    let lastComicIDPlayed: String = "c1"
    var lastComicPlayed: String {
        // Mapping comic ID to name; expand for more comics
        ["c1": "Ash Breaks A Bridge", "c2": "Unknown Comic"][lastComicIDPlayed, default: "Unknown Comic"]
    }
    
    var displayComicID: String {
        // This will take "c1", remove the "c", and return "1"
        lastComicIDPlayed.replacingOccurrences(of: "c", with: "")
    }
    
    // Calculate total questions for the comic
    private var totalQuestionsForComic: Int {
        questions.filter { $0.questionID.hasPrefix("\(lastComicIDPlayed)_") }.count
    }
    
    var sortedStudents: [Students] {
        students.sorted {
            correctAnswerPercentage(for: $0) > correctAnswerPercentage(for: $1)
        }
    }
    
    var body: some View {
        
        VStack {
            VStack {
                //inserted last session issue id and issue name
                Text("Issue \(displayComicID): \(lastComicPlayed)")
                    .font(.title3)
                    .bold()
                //inserted last session date
                Text("Last Session: \(dateFormatter())")
            }
            .padding()
            .padding(.horizontal, 30)
            .background(.white)
            .clipShape(.capsule)
            
            HStack{
                Spacer()
                Text("Correct Answers")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                    .background(.white, in: RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        .padding(.top, 30)
        .background(Color.background)
        List {
            ForEach(sortedStudents) { student in
                HStack {
                    Text(student.name)
                    Spacer()
                    //progress bar to show correct answers out of total answers
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 30)
                            .foregroundStyle(.red.opacity(0.75))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150 * (correctAnswerPercentage(for: student) / 100), height: 30)
                            .foregroundStyle(.green)
                        
                        Text("\(Int(correctAnswerPercentage(for: student)))%")
                            .font(.caption)
                            .padding(.leading)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(Color.background)
    }
    
    // Calculate percentage of correct answers for a student for the last comic played
    private func correctAnswerPercentage(for student: Students) -> Double {
        // Filter responses for the comic and for the specific student
        let responsesForComicAndStudent = responses.filter {
            $0.questionID.hasPrefix("\(lastComicIDPlayed)") && $0.studentID == student.id
        }
        
        // Check for total questions to avoid division by zero
        guard totalQuestionsForComic > 0 else { return 0.0 }
        
        // Count the number of correct answers for the specific student
        let correctCount = responsesForComicAndStudent.filter { $0.isCorrect }.count
        
        // Return the percentage
        return Double(correctCount) / Double(totalQuestionsForComic) * 100
    }
    
    //gets date for last session
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let date = Date()
        return formatter.string(from: date)
    }
    
}

#Preview {
    NavigationStack {
        StudentsView()
    }
}
