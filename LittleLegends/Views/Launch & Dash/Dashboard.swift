//
//  Dashboard.swift
//  LittleLegends
//
//  Created by John Newman on 18/8/2025.
//

import SwiftUI

struct Dashboard: View {
    
    @State var effect: Bool = false
    @State var drawOn: Bool = true
    
    @State var settingsSheet: Bool = false
    @State var classroomInsightsSheet: Bool = false
    
    @State var navPath = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $navPath) {
            GeometryReader { geo in
                ZStack {
                    LittleLegends.background.ignoresSafeArea()
                    VStack(spacing: geo.size.height * 0.03) {
                        Spacer()
                        HStack(spacing: geo.size.width * 0.03) {
                            //start a new session
                            NavigationLink {
                                CharacterSelect(navPath: $navPath)
                            } label: {
                                startSessionButton(width: geo.size.width * 0.32, height: geo.size.height * 0.25)
                            }
                            //resume last session button
                            resumeLastSessionButton(innerWidth: geo.size.width * 0.35, innerHeight: geo.size.height * 0.25, textWidth: geo.size.width * 0.25, textHeight: geo.size.height * 0.25, outerWidth: geo.size.width * 0.3, outerHeight: geo.size.height * 0.21)
                        }
                        .padding(.horizontal, geo.size.width * 0.05)
                        classroomInsightsButton(width: geo.size.width * 0.7, height: geo.size.height * 0.15)
                        settingsButton(width: geo.size.width * 0.7, height: geo.size.height * 0.15)
                        LittleLegendsTextView()
                    }
                    .padding(.bottom, geo.safeAreaInsets.bottom)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
        
        .sheet(isPresented: $classroomInsightsSheet) {
            ClassroomInsightsSheet()
        }
        
        .onAppear() {
            effect = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                effect = false
            }
            drawOn = false
            
        }
        
    }
    
    func resumeLastSessionButton(innerWidth: CGFloat, innerHeight: CGFloat, textWidth: CGFloat, textHeight: CGFloat, outerWidth: CGFloat, outerHeight: CGFloat) -> some View {
        NavigationLink {
//            CharacterSelect(navPath: $navPath)
        } label: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.resumeButton)
                    .frame(width: innerWidth, height: innerHeight)
                    .shadow(radius: 5)
                
                Text("Resume Last Session")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .bold()
                    .frame(width: textWidth, height: textHeight)
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    .frame(width: outerWidth, height: outerHeight)
            }
        }
    }

    func startSessionButton(width: CGFloat, height: CGFloat) -> some View {
        VStack {
            
            //start new game button
            Image(systemName: "play.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.blue.opacity(0.7))
                .symbolEffect(.drawOn, isActive: drawOn)
                .padding(.vertical, 5)
            
            Text("Start New Game")
                .foregroundStyle(.text)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
                
        }
        .frame(width: width, height: height)
        .background(
        RoundedRectangle(cornerRadius: 15)
            .fill(.generalButton)
            .shadow(radius: 5)
        )
    }
    
    func classroomInsightsButton(width: CGFloat, height: CGFloat) -> some View {
        Button {
            classroomInsightsSheet.toggle()
        } label: {
            
            HStack(spacing: 30) {
                
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.green, .purple)
                    .symbolEffect(.drawOn, isActive: drawOn)
                    .padding(.vertical, 5)
                    .padding(.leading)
                
                Text("Classroom Insights")
                    .foregroundStyle(.text)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    
            }
            .frame(width: width, height: height)
            .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.generalButton)
                .shadow(radius: 5)
            )
        }
    }
    
    func settingsButton(width: CGFloat, height: CGFloat) -> some View {
        Button {
            settingsSheet.toggle()
        } label: {
            HStack(spacing: 120) {
                
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.gray)
                    .symbolEffect(.rotate, isActive: effect)
                    .padding(.vertical, 5)
                
                Text("Settings")
                    .foregroundStyle(.text)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .padding(.trailing, 70)
                    
            }
            .frame(width: width, height: height)
            .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.generalButton)
                .shadow(radius: 5)
            )
        }
    }
}

#Preview {
    Dashboard()
}
