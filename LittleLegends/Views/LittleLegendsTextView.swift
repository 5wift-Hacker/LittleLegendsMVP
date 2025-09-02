//
//  LittleLegendsTextView.swift
//  LittleLegends
//
//  Created by John Newman on 18/8/2025.
//

import SwiftUI

struct LittleLegendsTextView: View {
    
    @Environment(\.colorScheme) var mode
    
    var body: some View {
        Spacer()
        VStack {
            Image(mode == .light ? "screenlogoblack" : "screenlogowhite")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 50)
                .bold()
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    LittleLegendsTextView()
}
