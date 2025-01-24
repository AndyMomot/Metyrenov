//
//  ProjectFilterCheckBox.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct ProjectFilterCheckBox: View {
    let currentFilter: ProjectFilterView.Filter
    @Binding var selection: ProjectFilterView.Filter
    
    var body: some View {
        HStack(spacing: 6) {
            Text(currentFilter.title)
                .foregroundStyle(.white)
                .font(.system(size: 8, weight: .regular))
            
            Button {
                withAnimation {
                    selection = currentFilter
                }
            } label: {
                if currentFilter == selection {
                    LinearGradientBackground(colors: [.azure, .skywave])
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .frame(width: 15)
                        .shadowModifier()
                        .overlay {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .padding(6)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.graphite)
                        .scaledToFit()
                        .frame(width: 15)
                        .shadowModifier()
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    ZStack {
        Color.graphite
        VStack {
            ProjectFilterCheckBox(
                currentFilter: .all,
                selection: .constant(.unFinished)
            )
            
            ProjectFilterCheckBox(
                currentFilter: .unFinished,
                selection: .constant(.unFinished)
            )
        }
        .padding()
    }
}
