//
//  CircularProgressView.swift
//  LittleLegends
//
//  Created by John Newman on 19/8/2025.
//
import SwiftUI

struct CircularProgressView: View {
    
    let percentage: Double
    @State private var animatedPercentage: Double = 0
    
    var body: some View {
        ZStack {
            // Background circle (gray)
            Circle()
                .stroke(lineWidth: 40)
                .frame(width: 150, height: 150)
                .foregroundStyle(.gray.gradient)
            
            // Progress circle (green, animates clockwise)
            Circle()
                .trim(from: 0, to: animatedPercentage / 100)
                .stroke(lineWidth: 40)
                .frame(width: 150, height: 150)
                .foregroundStyle(.blue.gradient)
                .rotationEffect(.degrees(-90)) // Start at 12 o'clock
                .animation(.easeInOut(duration: 1.5), value: animatedPercentage)
            
            // Percentage text
            Text("\(Int(animatedPercentage))%")
                .font(.title2)
                .foregroundStyle(.white)
        }
        .padding()
        .onAppear {
            withAnimation(.easeInOut) {
                animatedPercentage = percentage
            }
        }
    }
}

#Preview {
    CircularProgressView(percentage: 75)
}
