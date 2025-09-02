//
//  ContentView.swift
//  LittleLegends
//
//  Created by John Newman on 18/8/2025.
//

import SwiftUI

struct LaunchView: View {
    
    let backgroundColor: Color = .background
    
    @State var tappedStart: Bool = false
    
    //login details
    @State var username: String = ""
    @State var password: String = ""
    
    //navigation binding
    @State var travel: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    //background
                    backgroundColor.ignoresSafeArea()
                    backgroundDots()
                    
                    VStack {
                        titleImage(titleWidth: geo.size.width / 1.5, titleHeight: geo.size.height / 1.5)
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        Spacer()
                        
                        loginView(buttonWidth: geo.size.width / 2, buttonHeight: geo.size.height / 12)
                        
                        Spacer()
                    }
                    ageRating()
                }
                .navigationDestination(isPresented: $travel) {
                    Dashboard()
                }
            }
        }
    }
    
    func loginView(buttonWidth: CGFloat, buttonHeight: CGFloat) -> some View {
        VStack {
            Spacer()
            Spacer()
            
            if tappedStart {
                VStack {
                    VStack(spacing: 40) {
                        TextField("Username", text: $username)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: buttonWidth, height: buttonHeight)
                    
                    if !username.isEmpty && !password.isEmpty {
                        
                        VStack {
                            Button {
                                travel.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    username = ""
                                    password = ""
                                    tappedStart.toggle()
                                }
                            } label: {
                                Text("Login")
                                    .foregroundStyle(.text)
                                    .font(.title)
                                    .bold()
                                    .frame(width: buttonWidth, height: buttonHeight)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.generalButton)
                                            .shadow(radius: 5)
                                    )
                            }
                        }
                        .padding(.top, 30)
                    }
                }
                
            }else {
                
                Button {
                    withAnimation {
                        tappedStart.toggle()
                    }
                } label: {
                    Text("Start")
                        .foregroundStyle(.text)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.generalButton)
                                .shadow(radius: 5)
                        )
                    
                }
            }
            
            Spacer()
            
        }
    }

    func backgroundDots() -> some View {
        Image("bgDots")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }

    func titleImage(titleWidth: CGFloat, titleHeight: CGFloat) -> some View {
        Image("titleImage")
            .resizable()
            .frame(width: titleWidth, height: titleHeight)
            .padding(.top, 50)
    }
    
    func ageRating() -> some View {
        
        VStack {
            Spacer()
            
            Image("ageRating")
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

#Preview {
    LaunchView()
}
