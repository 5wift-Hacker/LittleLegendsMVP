import SwiftUI

struct QuestionView: View {
    let question: String
    let image: String
    let correctEmotion: ChosenEmotion
    let incorrectEmotions: [ChosenEmotion]
    let pages: [Character.Comic.Page]
    let currentPageIndex: Int
    
    @State var isPulsing: Bool = false
    
    @Binding var responses: [(questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool)]
    @Binding var navPath: NavigationPath
    
    @State private var selectedEmotion: ChosenEmotion?
    
    private var emotionOptions: [ChosenEmotion] {
        ([correctEmotion] + incorrectEmotions)
    }
    
    private var nextPage: Character.Comic.Page? {
        let nextIndex = currentPageIndex + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 450)
            
            Text(question)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            ForEach(emotionOptions, id: \.self) { emotion in
                Button(action: {
                    selectedEmotion = emotion
                    let questionID = mockQuestions.first { $0.questionText == question }?.questionID ?? ""
                    responses.append((questionID: questionID, chosenEmotion: emotion, isCorrect: emotion == correctEmotion))
                }) {
                    HStack {
                        Spacer()
                        Text(emotion.emoji)
                        
                        //display a checkmark next to the correct answer if it was chosen correctly, but display an x mark only next to the incorrect answer, if an incorrect answer was chosen.
                        Spacer()
                        if selectedEmotion == emotion {
                            Image(systemName: emotion == correctEmotion ? "checkmark" : "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(.trailing)
                        }
                        
                    }
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(width: 500, height: 100)
                    .background(buttonBackgroundColor(for: emotion))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                .padding(.horizontal)
                .disabled(selectedEmotion != nil)
            }
            
            VStack {
                if selectedEmotion != nil {
                    
                        NavigationLink {
                            if let nextPage = nextPage {
                                PageView(page: nextPage, pages: pages, currentPageIndex: currentPageIndex + 1, responses: $responses, navPath: $navPath)
                                    
                            } else {
                                ComicCompletedView(responses: responses, totalQuestions: pages.count, navPath: $navPath)
                            }
                        } label: {
                            AshNextButtonView()
                                .scaleEffect(isPulsing ? 1.1 : 1.0)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                                        isPulsing = true // Start pulsing when the button appears
                                    }
                                }
                        }
                        .padding(.top, 75)
                }
            }
            .frame(width: 100, height: 100)
            .animation(.easeIn(duration: 0.2), value: selectedEmotion)
            
            .onDisappear {
                isPulsing = false
            }
            LittleLegendsTextView()
        }
        .onAppear {
            print("QuestionView: currentPageIndex = \(currentPageIndex), pages.count = \(pages.count), responses.count = \(responses.count)")
        }
    }
    
    private func buttonBackgroundColor(for emotion: ChosenEmotion) -> Color {
        guard let selected = selectedEmotion else {
            return Color.ashemotionselect
        }
        if selected == emotion {
            return emotion == correctEmotion ? .green : .red
        }
        return emotion == correctEmotion ? .green : .red
    }
}

#Preview {
    NavigationStack {
        QuestionView(
            question: "How do you feel?",
            image: "q1panel",
            correctEmotion: .q1CA,
            incorrectEmotions: [.q1IA2, .q1IA1],
            pages: [
                Character.Comic.Page(thumbnail: "buttonp1ash", pageImage: "ashp1", questionImage: "q1panel", pageText: "", questionID: "c1_p1"),
                Character.Comic.Page(thumbnail: "buttonp2ash", pageImage: "ashp2", questionImage: "q2panel", pageText: "", questionID: "c1_p2"),
                Character.Comic.Page(thumbnail: "buttonp3ash", pageImage: "ashp3", questionImage: "q3panel", pageText: "", questionID: "c1_p3"),
                Character.Comic.Page(thumbnail: "buttonp4ash", pageImage: "ashp4", questionImage: "q4panel", pageText: "", questionID: "c1_p4"),
                Character.Comic.Page(thumbnail: "buttonp5ash", pageImage: "ashp5", questionImage: "q5panel", pageText: "", questionID: "c1_p5"),
                Character.Comic.Page(thumbnail: "buttonp6ash", pageImage: "ashp6", questionImage: "q6panel", pageText: "", questionID: "c1_p6")
            ],
            currentPageIndex: 3,
            responses: .constant([]),
            navPath: .constant(NavigationPath())
        )
    }
}
