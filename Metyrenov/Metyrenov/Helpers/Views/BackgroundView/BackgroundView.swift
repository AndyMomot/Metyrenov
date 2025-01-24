//
//  BackgroundView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.graphite
            Asset.bgImage.swiftUIImage
                .resizable()
        }
    }
}

#Preview {
    BackgroundView()
}
