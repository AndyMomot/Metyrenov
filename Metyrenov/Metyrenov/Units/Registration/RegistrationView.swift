//
//  RegistrationView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    
    var body: some View {
        ZStack {
            Color.graphite
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                HStack {
                    Text("Cześć,\nPowitanie!")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        CustomTextField(
                            title: "Wprowadź swój pseudonim, aby kontynuować",
                            placeholder: "Twój pseudonim",
                            text: $viewModel.nickname)
                        
                        NextButton(title: "Wejść") {
                            viewModel.saveNickname {
                                DispatchQueue.main.async {
                                    rootViewModel.setFlow(.main)
                                }
                            }
                        }
                        .disabled(viewModel.nickname.count < 3)
                    }
                }
                .scrollIndicators(.never)
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView()
}
