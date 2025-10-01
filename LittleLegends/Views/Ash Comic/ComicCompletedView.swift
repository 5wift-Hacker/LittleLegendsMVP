import SwiftUI

struct ComicCompletedView: View {
    let responses: [(questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool)]
    let totalQuestions: Int
    @Binding var navPath: NavigationPath
    @State private var isNavigatingToDashboard = false
    
    var body: some View {
        // Compute points from the passed-in responses
        let correctCount = responses.filter { $0.isCorrect }.count
        let earnedPoints = correctCount * pointsPerCorrectAnswer

        RewardsView(earnedPoints: earnedPoints, navPath: $navPath)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ComicCompletedView(
            responses: [
                (questionID: "c1_p1", chosenEmotion: .q1CA, isCorrect: true),
                (questionID: "c1_p2", chosenEmotion: .q1IA1, isCorrect: false),
                (questionID: "c1_p3", chosenEmotion: .q1CA, isCorrect: true)
            ],
            totalQuestions: 6,
            navPath: .constant(NavigationPath())
        )
    }
}
