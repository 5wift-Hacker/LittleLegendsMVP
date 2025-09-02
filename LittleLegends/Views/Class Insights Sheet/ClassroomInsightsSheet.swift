//
//  ClassroomInsights.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//

import SwiftUI

//classroom insights shows scores avg scores from previous game

/*
 2 tabs:
 
 tab 1: classroom insights - display average & list of all questions and total amount correct
 
 tab 2: students - list of all students (tappable) > navigate to all answers to last quiz
 - list of answers "page" of that individual student
 */

struct ClassroomInsightsSheet: View {
    
    let questions = mockQuestions
    
    var body: some View {
        
        //top circular progress view shows average class score
        NavigationStack {
            TabView {
                Tab("Class Insights", systemImage: "book.fill") {
                    ClassInsightsView()
                    
                }
                .tabPlacement(.pinned)
                Tab("Students", systemImage: "person.fill") {
                    StudentsView()
                    
                }
                .tabPlacement(.pinned)
            }
        }
    }
}

#Preview {
    ClassroomInsightsSheet()
}
