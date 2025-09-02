//
//  AshNextButton.swift
//  LittleLegends
//
//  Created by John Newman on 28/8/2025.
//

import SwiftUI

struct AshNextButtonView: View {
    var body: some View {
        VStack {
            Text("Next")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .bold()
                .frame(width: 300, height: 75)
                .background(.ashemotionselect)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    AshNextButtonView()
}
