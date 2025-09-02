import SwiftUI

struct ComicCompletedView: View {
    let responses: [(questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool)]
    let totalQuestions: Int
    @Binding var navPath: NavigationPath
    @State private var isNavigatingToDashboard = false
    
    private var correctCount: Int {
        responses.filter { $0.isCorrect }.count
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Comic Completed!")
                .font(.largeTitle)
                .foregroundStyle(.text)
                .bold()
            
            Text("You got \(correctCount) out of \(totalQuestions) correct!")
                .font(.title)
                .foregroundStyle(.text)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Detailed results summary
            ScrollView {
                ForEach(responses, id: \.questionID) { response in
                    HStack(spacing: 10) {
                        Text(mockQuestions.first { $0.questionID == response.questionID }?.questionText ?? response.questionID)
                            .font(.headline)
                            .foregroundStyle(.text)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Text(response.chosenEmotion.emoji)
                            .font(.body)
                            .foregroundStyle(.text)
                        
                        Image(systemName: response.isCorrect ? "checkmark.circle" : "xmark.circle")
                            .font(.title)
                            .foregroundStyle(response.isCorrect ? .green : .red)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .frame(maxHeight: 300)
            
            Button {
                navPath = NavigationPath() // Clear the navigation stack
                isNavigatingToDashboard = true // Trigger navigation
            } label: {
                VStack {
                    Text("Done")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 300, height: 75)
                        .background(.ashemotionselect)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .background(Color.background).ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isNavigatingToDashboard) {
            Dashboard()
        }
        .onAppear {
            print("ComicCompletedView: correctCount = \(correctCount), totalQuestions = \(totalQuestions), navPath.count = \(navPath.count)")
        }
    }
}

#Preview {
    NavigationStack {
        ComicCompletedView(
            responses: [
                (questionID: "c1_p1", chosenEmotion: .q1CA, isCorrect: true),
                (questionID: "c1_p2", chosenEmotion: .q1IA1, isCorrect: false)
            ],
            totalQuestions: 6,
            navPath: .constant(NavigationPath())
        )
    }
}
