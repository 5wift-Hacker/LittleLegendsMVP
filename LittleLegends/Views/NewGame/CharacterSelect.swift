//
//  CharacterSelect.swift
//  LittleLegends
//
//  Created by John Newman on 29/8/2025.
//

struct Character: Identifiable {
    var id = UUID()
    var image: String
    var comics: [Comic]
    
    struct Comic: Identifiable {
        var id = UUID()
        var issueCover: String
        var pages: [Page]
        
        struct Page: Identifiable {
            var id = UUID()
            var thumbnail: String
            var pageImage: String
            var pageText: String
            var questionID: String
            
        }
    }
}

let characters: [Character] = [
    
    Character(image: "buttonmax", comics: []),
    Character(image: "buttonluma", comics: []),
    Character(image: "buttonash", comics: [
        
        Character.Comic(
            issueCover: "buttonissue1ash",
            pages: [
                
                Character.Comic.Page(thumbnail: "buttonp1ash", pageImage: "ashp1", pageText: "Ash accidentally knocks over the gnomes' bridge.", questionID: "c1_p1"),
                Character.Comic.Page(thumbnail: "buttonp2ash", pageImage: "ashp2", pageText: "Ash tries to hammer the bridge but struggles.", questionID: "c1_p2"),
                Character.Comic.Page(thumbnail: "buttonp3ash", pageImage: "ashp3", pageText: "Ash bends nails, the bridge cracks, and he yells as gnomes glare", questionID: "c1_p3"),
                Character.Comic.Page(thumbnail: "buttonp4ash", pageImage: "ashp4", pageText: "Bridge cracks further, everyone stares at Ash.", questionID: "c1_p4"),
                Character.Comic.Page(thumbnail: "buttonp5ash", pageImage: "ashp5", pageText: "Ash storms off in snow, yelling.", questionID: "c1_p5"),
                Character.Comic.Page(thumbnail: "buttonp6ash", pageImage: "ashp6", pageText: "Ash stomps alone in the snow.", questionID: "c1_p6")
            ])
    ]),
    Character(image: "buttonmica", comics: [])
]

import SwiftUI

struct CharacterSelect: View {
    
    @Binding var navPath: NavigationPath
    
    var body: some View {
        
        NavigationStack(path: $navPath) {
            ZStack {
                LittleLegends.background.ignoresSafeArea()
                
                ScrollView {
                        VStack {
                            ForEach(characters) { character in
                                NavigationLink {
                                    IssueSelection(comics: character.comics, navPath: $navPath)
                                } label: {
                                    Image(character.image)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top, characterSelectImagePadding)
                        .frame(maxWidth: .infinity)
                }
            }
            .overlay {
                VStack {
                    Text("Character Select")
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
//
//#Preview {
//        CharacterSelect()
//}
