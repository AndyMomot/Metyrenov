//
//  LinearGradientBackground.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import SwiftUI

struct LinearGradientBackground: View {
    var colors: [Color] = [.deepIndigo, .azure]
    
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}

#Preview {
    LinearGradientBackground()
}
