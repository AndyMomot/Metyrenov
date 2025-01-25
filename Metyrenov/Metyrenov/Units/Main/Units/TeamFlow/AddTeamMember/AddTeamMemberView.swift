//
//  AddTeamMemberView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct AddTeamMemberView: View {
    let teamID: String
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        BackgroundView()
            .ignoresSafeArea()
        
        VStack(spacing: 40) {
            BackButton(title: "Dodawanie nowego kreatora")
            
            ScrollView {
                VStack(spacing: 20) {
                    CustomTextField(
                        title: "Imię Mistrza",
                        placeholder: "Wprowadź nazwę nowego mastera...",
                        text: $viewModel.name
                    )
                    
                    CustomTextField(
                        title: "Numer telefonu mistrza",
                        placeholder: "Wprowadź numer telefonu kreatora...",
                        text: $viewModel.phone
                    )
                    
                    CustomTextField(
                        title: "E-mail mistrza",
                        placeholder: "Wprowadź adres e-mail mistrza...",
                        text: $viewModel.email
                    )
                    
                    HStack {
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            if viewModel.image == UIImage() {
                                Image(systemName: "photo.badge.plus")
                                    .foregroundStyle(LinearGradient(
                                        colors: [.skywave, .azure],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                            } else {
                                
                            }
                        }
                        
                        Text("Dodaj zdjęcie/szkic")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .light))
                        Spacer()
                    }
                }
            }
            
            NextButton(title: "Wyświetl polecenia") {
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddTeamMemberView(teamID: UUID().uuidString)
}
