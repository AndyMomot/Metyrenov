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
            
            VStack(spacing: 20) {
                HStack {
                    Text("Cześć,\nPowitanie!")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                    Spacer()
                    
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(height: 70)
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        CustomTextField(
                            title: "Wprowadź swój pseudonim, aby kontynuować",
                            placeholder: "Twój pseudonim",
                            text: $viewModel.nickname)
                        
                        HStack(spacing: 0) {
                            UserTypeButton(
                                model: .personal,
                                selectedType: $viewModel.type
                            )
                            
                            Spacer(minLength: 20)
                            
                            UserTypeButton(
                                model: .company,
                                selectedType: $viewModel.type
                            )
                        }
                    }
                }
                .scrollIndicators(.never)
                
                NextButton(title: "Wejść") {
                    viewModel.saveNickname {
                        DispatchQueue.main.async {
                            rootViewModel.setFlow(.main)
                        }
                    }
                }
                .disabled(viewModel.nickname.count < 3)
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView()
}
