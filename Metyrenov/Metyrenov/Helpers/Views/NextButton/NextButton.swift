//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var colors: [Color] = [.azure, .skywave]
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                LinearGradient(
                    colors: colors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .clipShape( RoundedRectangle(cornerRadius: 10))
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 15))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .frame(height: 54)
            .shadowModifier()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
            
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}
