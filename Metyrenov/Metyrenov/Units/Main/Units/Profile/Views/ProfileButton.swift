//
//  ProfileButton.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import SwiftUI

struct ProfileButton: View {
    let title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 26) {
                Circle()
                    .foregroundStyle(LinearGradient(
                        colors: [.skywave, .azure],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(.graphite)
            .cornerRadius(10, corners: .allCorners)
            .shadowModifier()
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: 80)
    }
}

#Preview {
    ZStack {
        Color.graphite
        ProfileButton(title: "Manage categories") {}
            .padding()
    }
}
