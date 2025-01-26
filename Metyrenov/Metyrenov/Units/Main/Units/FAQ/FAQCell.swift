//
//  FAQCell.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct FAQCell: View {
    let model: FAQView.Model
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ChartRow(text: model.title)
            
            Text(model.text)
                .foregroundStyle(.white)
                .font(.system(size: 10, weight: .regular))
            
            Spacer()
        }
        .padding()
        .background {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(model.imageName)
                        .padding(10)
                        .background(.graphite)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadowModifier()
                }
            }
        }
        .background(.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        FAQCell(model: .init(
            title: "Pławna:",
            text: """
            Określ budżet: weź pod uwagę koszty materiałów, robocizny i możliwe nieprzewidziane wydatki.
            Stwórz szczegółowy plan pracy, uwzględniający terminy.
            """,
            imageName: Asset.faq1.name
        ))
        .padding()
    }
}
