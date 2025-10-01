//
//  RewardsView.swift
//  LittleLegends
//
//  Created by John Newman on 18/9/2025.
//

import SwiftUI

struct RewardsView: View {
    
    @State var grayRevealed = false
    @State var yellowRevealed = false
    let earnedPoints: Int
    @Binding var navPath: NavigationPath
    @State private var isNavigatingToDashboard = false
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()

            VStack(alignment: .center, spacing: 24) {
                // Top header with half-circle background
                RewardsHeader()
                Spacer()
                Spacer()
                // Reward tiles row
                RewardTilesRow(grayRevealed: $grayRevealed, yellowRevealed: $yellowRevealed, earnedPoints: earnedPoints)
                Spacer()
                // Stats section
                StatsSection()

                // Primary action
                Button("Play again to unlock the next level") {
                    // Reset back to the root (Dashboard) and navigate
                    navPath = NavigationPath()
                    isNavigatingToDashboard = true
                }
                .padding()
                .glassEffect(.regular.interactive().tint(.ashemotionselect), in: .rect(cornerRadius: 15))
                .tint(.white)
                .bold()
                .font(.largeTitle)
                .padding(.top, 8)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .onAppear {
            // We flip the booleans at specific times. This schedules WHEN the state changes,
            // while the per-item `.delay` below controls WHEN each item's animation begins.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                grayRevealed = true
            }
            
            // Trigger the yellow overlay later; items still stagger via their own `.delay`.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                yellowRevealed = true
            }
            
        }
        .navigationDestination(isPresented: $isNavigatingToDashboard) {
            Dashboard()
        }
    }
}

private struct RewardsHeader: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Half-circle background under the header
            GeometryReader { geo in
                let diameter = geo.size.width * 1.5
                let height = geo.size.width * 1.1
                Ellipse()
                    .fill(Color.background)
                    .frame(width: diameter, height: height)
                    .position(x: geo.size.width / 2, y: 0)
            }
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Class Progress Report")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.top, 100)
                    .bold()

                Text("Great work team! Here's how your class scored today:")
                    .font(.system(size: 45))
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.horizontal)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: 800)
            .padding(.top, 16)
        }
        // Height of the header area; adjust if you want a bigger/smaller arc
        .frame(height: 300)
    }
}

private struct RewardTilesRow: View {
    
    @Binding var grayRevealed: Bool
    @Binding var yellowRevealed: Bool
    let earnedPoints: Int
    
    // Star thresholds: a star unlocks when earnedPoints >= threshold
    let points: [Int] = [300, 600, 900, 1200]

    var body: some View {
        HStack(spacing: 16) {
            // Staggered stars explanation:
            // - points.enumerated() produces pairs (offset, element) like (0, 300), (1, 600), ...
            // - We destructure those into `index` (the offset) and `totalPoints` (the value).
            // - id: \.offset tells SwiftUI to use the index as a stable identity for diffing.
            // - We use `index` to compute a per-item `.delay` so each star animates one after another.
            ForEach(points.enumerated(), id: \.offset) { index, totalPoints in
                // Unlock this star if we've reached its threshold
                let unlocked = earnedPoints >= totalPoints
                
                VStack(spacing: 8) {
                    ZStack {
                        Image("stargrey")
                            .resizable()
                            .scaledToFit()
                        // Pop-in scale (optionally add a tiny fade)
                            .scaleEffect((grayRevealed) ? 1.0 : 0.6)
                            .opacity((grayRevealed) ? 1.0 : 0.0) // stays hidden if not unlocked
                            .animation(
                                // .delay waits before this view's animation starts.
                                // Each item uses its own `index` to stagger the start time (cascade effect).
                                .snappy(duration: 0.75, extraBounce: 0.4)
                                    .delay(Double(index) * 0.15),
                                // `value:` is the state that triggers this animation when it changes.
                                value: grayRevealed
                            )
                            .shadow(radius: 5)
                        
                        Image("staryellow")
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                Color.brightyellow
                                    .mask {
                                        Image("staryellow")
                                            .resizable()
                                            .scaledToFit()
                                    }
                            }
                        // Pop-in scale (optionally add a tiny fade)
                            .scaleEffect((yellowRevealed && unlocked) ? 1.0 : 0.4)
                            .opacity((yellowRevealed && unlocked) ? 1.0 : 0.0) // stays hidden if not unlocked
                            .animation(
                                // Separate animation for the yellow fill; it also staggers per item.
                                .snappy(duration: 0.75, extraBounce: 0.5)
                                    .delay(Double(index) * 0.15),
                                value: yellowRevealed
                            )
                    }

                    Text("\(totalPoints)")
                        .bold()
                        .font(.system(size: 48))
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct StatsSection: View {
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                Text("Multiple Choice Quiz: 1200")
                    
                    .bold()
                    .font(.largeTitle)
                Text("Total Games Failed: 0")
                    .bold()
                    .font(.largeTitle)
            }
            .padding(.bottom, 30)
    }
}

#Preview {
    RewardsView(earnedPoints: 600, navPath: .constant(NavigationPath())) // Example: 3 correct answers * 200 points
}
