//
//  IssueSelection.swift
//  LittleLegends
//
//  Created by John Newman on 29/8/2025.
//

import SwiftUI

struct IssueSelection: View {
    
    let comics: [Character.Comic]
    
    @Binding var navPath: NavigationPath
    
    var body: some View {
        
        if comics.isEmpty {
            EmptyView()
        }else {
            ZStack {
                LittleLegends.background.ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        ForEach(comics) { comic in
                            NavigationLink {
                                PageSelection(pages: comic.pages, navPath: $navPath)
                            } label: {
                                Image(comic.issueCover)
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
                    Text("Issue Selection")
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
//    IssueSelection()
//}
