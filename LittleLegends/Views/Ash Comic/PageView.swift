import SwiftUI

struct PageView: View {
    let page: Character.Comic.Page
    let pages: [Character.Comic.Page]
    let currentPageIndex: Int
    @Binding var responses: [(questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool)]
    @Binding var navPath: NavigationPath
    
    private var question: MockQuestions? {
        mockQuestions.first { $0.questionID == page.questionID }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(page.pageImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 750, maxHeight: 750)
            
            Spacer()
            
            Text(page.pageText)
                .foregroundStyle(.text)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            
            LittleLegendsTextView()
        }
        .frame(maxWidth: 700)
        .overlay {
            VStack {
                Spacer()
                
                if let question = question {
                    NavigationLink {
                        QuestionView(
                            question: question.questionText,
                            image: page.questionImage,
                            correctEmotion: question.correctEmotion,
                            incorrectEmotions: question.answerOptions.filter { $0 != question.correctEmotion },
                            pages: pages,
                            currentPageIndex: currentPageIndex,
                            responses: $responses,
                            navPath: $navPath
                        )
                    } label: {
                        AshNextButtonView()
                            .padding(.bottom, 10)
                    }
                } else {
                    NavigationLink {
                        if let nextPage = pages[safe: currentPageIndex + 1] {
                            PageView(page: nextPage, pages: pages, currentPageIndex: currentPageIndex + 1, responses: $responses, navPath: $navPath)
                        } else {
                            ComicCompletedView(responses: responses, totalQuestions: pages.count, navPath: $navPath)
                        }
                    } label: {
                        AshNextButtonView()
                    }
                }
            }
            .padding(.bottom, 80)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Close page")
                    navPath = NavigationPath() // Reset stack on close
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .bold()
                }
                .tint(Color.red)
            }
        }
        .onAppear {
            print("PageView: questionID = \(page.questionID), currentPageIndex = \(currentPageIndex), pages.count = \(pages.count), questionFound = \(question != nil), responses.count = \(responses.count)")
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    NavigationStack {
        PageView(
            page: Character.Comic.Page(thumbnail: "ashp1", pageImage: "ashp1", questionImage: "q1panel", pageText: "", questionID: "c1_p1"),
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
