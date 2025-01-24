//
//  HomeView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                NavigationBarView()
                    .padding(.trailing)
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.leading)
            
            VStack {
                Spacer()
                
                switch viewModel.userType {
                case .company:
                    HStack(spacing: 10) {
                        NextButton(title: "Dodaj nowy projekt") {
                            
                        }
                        
                        NextButton(title: "Wyświetl polecenia",
                                   titleColors: [.azure, .skywave],
                                   bgColors: [.graphite]) {
                            
                        }
                    }
                case .personal:
                    NextButton(title: "Dodaj nowy projekt") {
                        
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getUser()
        }
    }
}

#Preview {
    HomeView()
}
