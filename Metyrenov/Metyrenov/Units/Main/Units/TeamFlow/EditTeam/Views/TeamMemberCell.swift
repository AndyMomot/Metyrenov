//
//  TeamMemberCell.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct TeamMemberCell: View {
    let member: TeamMember
    var onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                HStack {
                    Spacer()
                    TeamMemberImage(imageId: member.id)
                        .frame(width: 77, height: 77)
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    Spacer()
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.redCustom)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            
            Group {
                Text(member.fullName)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(member.phone)
                    .foregroundStyle(LinearGradient(
                        colors: [.skywave, .azure],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .font(.system(size: 12, weight: .bold))
                
                Text(member.email)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundStyle(.white)
        }
        .padding()
        .background(Color.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        TeamMemberCell(member: .init(fullName: "Alex", phone: "123", email: "@gmail")) {}
            .frame(width: 165)
    }
}
