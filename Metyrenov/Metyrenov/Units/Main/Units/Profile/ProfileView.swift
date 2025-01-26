//
//  ProfileView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Text("Ustawienia")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold))
                
                ScrollView {
                    VStack(spacing: 15) {
                        // Image
                        HStack {
                            Button {
                                viewModel.showImagePiker.toggle()
                            } label: {
                                Circle()
                                    .fill(.graphite)
                                    .shadowModifier()
                                    .overlay {
                                        Asset.camera.swiftUIImage
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 44)
                            
                            Spacer()
                            
                            if viewModel.image == UIImage() {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.deepIndigo)
                                    .padding()
                                    .background(LinearGradientBackground())
                                    .clipShape(Circle())
                                    .frame(maxWidth: 173)
                            } else {
                                Image(uiImage: viewModel.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 173, height: 173)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                            
                            Button {
                                viewModel.showAlert.toggle()
                            } label: {
                                Circle()
                                    .fill(.graphite)
                                    .shadowModifier()
                                    .overlay {
                                        Asset.exit.swiftUIImage
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 44)
                        }
                        
                        // Name
                        TextField(text: $viewModel.userName) {
                            Text("Wpisz swoje imię")
                                .foregroundStyle(.white.opacity(0.6))
                                .font(.system(size: 20, weight: .regular))
                                .multilineTextAlignment(.center)
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        
                        // Buttons
                        if let url = viewModel.appStoreURL {
                            ProfileButton(title: "Zaktualizować") {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                        
                        if viewModel.supportURL != nil {
                            ProfileButton(title: "Wsparcie") {
                                viewModel.showSupport.toggle()
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.getUser()
        }
        .sheet(isPresented: $viewModel.showImagePiker) {
            ImagePicker(selectedImage: $viewModel.image) {
                viewModel.saveUserImage()
            }
        }
        .sheet(isPresented: $viewModel.showSupport) {
            SwiftUIViewWebView(url: viewModel.supportURL)
        }
        .alert("Vymažte data a ukončet", isPresented: $viewModel.showAlert) {
            Button("Anulować", role: .cancel) {}
            Button("Potvrdit", role: .destructive) {
                viewModel.removeData()
                DispatchQueue.main.async {
                    rootViewModel.setFlow(.onboarding)
                }
            }
        } message: {
            Text("Czy na pewno chcesz zamknąć aplikację i usunąć wszystkie dane?")
        }
    }
}

#Preview {
    ProfileView()
}
