import SwiftUI

struct PageSelection: View {
    let pages: [Character.Comic.Page]
    
    @Binding var navPath: NavigationPath
    
    @State private var responses: [(questionID: String, chosenEmotion: ChosenEmotion, isCorrect: Bool)] = []
    
    var body: some View {
        if pages.isEmpty {
            Text("Nothing here")
        } else {
            ZStack {
                LittleLegends.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 0) {
                        Button {
                            // Start from beginning
                            responses = [] // Reset responses
                        } label: {
                            Text("Start From Beginning")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.text)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color.black, radius: 5)
                                .padding(.horizontal, 40)
                        }
                        
                        ForEach(pages.indices, id: \.self) { index in
                            NavigationLink {
                                PageView(page: pages[index], pages: pages, currentPageIndex: index, responses: $responses, navPath: $navPath)
                            } label: {
                                Image(pages[index].thumbnail)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 30)
                            }
                        }
                    }
                    .padding(.top, issueSelectionImagePadding)
                }
            }
            .overlay {
                VStack {
                    Text("Page Selection")
                        .font(.largeTitle)
                        .foregroundStyle(.text)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        PageSelection(pages: [Character.Comic.Page(thumbnail: "buttonp1ash", pageImage: "ashp1", pageText: "Ash accidentally knocks over the gnomes' bridge.", questionID: "c1_p1")])
//    }
//}
