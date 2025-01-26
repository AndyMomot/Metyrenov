//
//  FAQView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct FAQView: View {
    @StateObject private var viewModel = ViewModel()
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                NavigationBarView()
                    .padding(.trailing)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Wskazówki dotyczące zarządzania naprawami")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom)
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.items) { item in
                                FAQCell(model: item)
                            }
                        }
                    }
                    .padding()
                    .background(.graphite)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadowModifier()
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FAQView()
}
