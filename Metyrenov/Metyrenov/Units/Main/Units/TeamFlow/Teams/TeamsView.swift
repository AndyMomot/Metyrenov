//
//  TeamsView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct TeamsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    NavigationBarView()
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            HStack {
                                Text("Twoje zespoły")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                            
                            SearchView(query: $viewModel.query)
                        }
                        .padding()
                        .background(Color.graphite)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadowModifier()
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.getTeams()
            }
        }
    }
}

#Preview {
    TeamsView()
}
