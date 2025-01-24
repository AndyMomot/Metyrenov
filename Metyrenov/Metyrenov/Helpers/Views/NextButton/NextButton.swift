//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var titleColors = [Color.white]
    var bgColors: [Color] = [.skywave, .azure]
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                LinearGradient(
                    colors: bgColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(title)
                    .foregroundStyle(LinearGradient(
                        colors: titleColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 15))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .frame(height: 44)
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
