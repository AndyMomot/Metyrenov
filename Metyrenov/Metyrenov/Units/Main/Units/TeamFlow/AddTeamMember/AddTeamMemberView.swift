//
//  AddTeamMemberView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct AddTeamMemberView: View {
    let teamID: String
    var onDismiss: () -> Void
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
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
                        
                        HStack(spacing: 20) {
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
                                        .padding(20)
                                        .background(.graphite)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadowModifier()
                                } else {
                                    Image(uiImage: viewModel.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadowModifier()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Text("Dodaj zdjęcie/szkic")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .light))
                            Spacer()
                        }
                    }
                }
                .scrollIndicators(.never)
                
                NextButton(title: "Wyświetl polecenia") {
                    viewModel.addMember(teamID: teamID) {
                        onDismiss()
                        dismiss.callAsFunction()
                    }
                }
                .disabled(!viewModel.isValid)
                .ignoresSafeArea(.keyboard)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    AddTeamMemberView(teamID: UUID().uuidString) {}
}
