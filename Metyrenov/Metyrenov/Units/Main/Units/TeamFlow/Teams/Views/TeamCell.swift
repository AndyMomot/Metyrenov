//
//  TeamCell.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct TeamCell: View {
    var team: Team
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(team.members) { member in
                        TeamMemberImage(imageId: member.id)
                            .frame(maxWidth: 50, maxHeight: 50)
                    }
                }
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(team.name)
                        .font(.system(size: 14, weight: .semibold))
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 12)
                        
                        Text("\(team.members.count)")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .foregroundStyle(.white)
                Spacer()
            }
        }
        .padding()
        .background(.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        HStack {
            Spacer()
            TeamCell(team: .init(
                name: "Dream Team",
                members: [
                    .init(fullName: "Alex", phone: "123", email: "@gmail"),
                    .init(fullName: "Ted", phone: "123", email: "@gmail"),
                    .init(fullName: "Robert", phone: "123", email: "@gmail"),
                    .init(fullName: "Joe", phone: "123", email: "@gmail"),
                    .init(fullName: "Lois", phone: "123", email: "@gmail"),
                    .init(fullName: "Ruppert", phone: "123", email: "@gmail"),
                    .init(fullName: "Bred", phone: "123", email: "@gmail"),
                ]
            ))
            .padding()
            Spacer()
        }
    }
}
