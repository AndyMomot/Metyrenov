//
//  DateChartRow.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct DateChartRow: View {
    let date: Date
    
    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.graphite)
                .frame(width: 20)
                .shadowModifier()
                .overlay {
                    Circle()
                        .foregroundStyle(LinearGradient(
                            colors: [.skywave, .azure],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .padding(4)
                }
            
            Text(date.toString(format: .ddMMyyyy))
                .foregroundStyle(LinearGradient(
                    colors: [.skywave, .azure],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .font(.system(size: 8, weight: .semibold))
        }
    }
}

#Preview {
    ZStack {
        Color.graphite
        DateChartRow(date: .init())
            .padding()
    }
}
