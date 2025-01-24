//
//  UserTypeButton.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct UserTypeButton: View {
    let model: User.UserType
    @Binding var selectedType: User.UserType
    
    var body: some View {
        Button {
            withAnimation {
                selectedType = model
            }
        } label: {
            VStack(spacing: 15) {
                Image(model.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 76)
                
                HStack {
                    Spacer()
                    Text(model.displayName)
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .padding(30)
            .background(Color.graphite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadowModifier(
                color: model == selectedType ? .azure.opacity(0.25) : .ashGray.opacity(0.25))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.graphite
        HStack(spacing: 20) {
            UserTypeButton(model: .personal,
                           selectedType: .constant(.company))
            
            UserTypeButton(model: .company,
                           selectedType: .constant(.company))
        }
        .padding()
    }
}
