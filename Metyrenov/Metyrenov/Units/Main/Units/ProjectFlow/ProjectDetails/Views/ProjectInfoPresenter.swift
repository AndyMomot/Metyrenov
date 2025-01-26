//
//  ProjectInfoPresenter.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct ProjectInfoPresenter: View {
    let text: String
    var alignment: TextAlignment = .center
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(alignment)
            Spacer()
        }
        .padding(10)
        .background(Color.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        VStack(spacing: 20) {
            ProjectInfoPresenter(text: "21/03/2025")
            ProjectInfoPresenter(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", alignment: .leading)
        }
        .padding()
    }
}
