//
//  CreateProjectView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct CreateProjectView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var tabBarViewModel: TabBar.ViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                BackButton(title: "Dodawanie nowego projektu")
                
                ScrollView {
                    VStack(spacing: 15) {
                        CustomTextField(
                            title: "Nazwa projektu",
                            placeholder: "Wprowadź nazwę...",
                            text: $viewModel.name)
                        
                        DatePickerView(
                            title: "Termin ostateczny",
                            selection: $viewModel.date
                        )
                        
                        CustomTextField(
                            title: "Adres",
                            placeholder: "Wprowadź adres...",
                            text: $viewModel.address)
                        
                        MenuPicker(
                            title: "Zespół",
                            items: viewModel.teams.map { $0.name },
                            showAddButton: true,
                            placeholder: "Wybierz zespół",
                            selection: $viewModel.selectedTeam) {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        tabBarViewModel.selection = TabBar.TabBarSelectionView.team.rawValue
                                    }
                                }
                            }
                        
                        CustomTextField(
                            title: "Opis projektu",
                            placeholder: "Wprowadź opis...",
                            text: $viewModel.description)
                        
                        CustomTextField(
                            title: "Budżet",
                            placeholder: "00",
                            text: $viewModel.budget)
                        .keyboardType(.numberPad)
                        
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
                
                NextButton(title: "Dodaj nowy projekt") {
                    viewModel.saveProject {
                        dismiss.callAsFunction()
                    }
                }
                .disabled(!viewModel.isValid)
            }
            .padding(.horizontal)
        }
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.getUser()
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    CreateProjectView()
}
