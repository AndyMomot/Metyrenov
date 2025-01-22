//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color.graphite
                .ignoresSafeArea()
            
            VStack {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 50) {
                    Text(item.text)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.top, 50)
                        .padding(.horizontal, 30)
                    
                    CircularProgressBar(
                        progress: item.progress,
                        trackColor: .graphite,
                        progressColor: .azure,
                        lineWidth: 6,
                        text: "\(item.rawValue + 1)",
                        textColor: .white,
                        font: .system(size: 24, weight: .semibold)
                    )
                    .frame(width: 75)
                    
                    if item == .third {
                        VStack(spacing: 10) {
                            NextButton(title: "Rozpocznij") {
                                viewModel.showRegistration.toggle()
                            }
                            
                            Button {
                                DispatchQueue.main.async {
                                    withAnimation {
                                        withAnimation {
                                            viewModel.showPrivacyPolicy.toggle()
                                        }
                                    }
                                }
                            } label: {
                                Group {
                                    Text("Zgadzam się z")
                                        .foregroundColor(.white)
                                        +
                                    Text(" polityką prywatności")
                                        .foregroundColor(.azure)
                                }
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                            }
                        }
                        .padding(.horizontal, 30)
                    } else {
                        HStack {
                            NextButton(
                                title: "Pominąć",
                                colors: [.graphite]) {
                                    withAnimation {
                                        currentPageIndex = item.lastIndex
                                    }
                                }
                                .offset(x: -10)
                            
                            Spacer(minLength: 30)
                            
                            NextButton(title: "Dalej") {
                                withAnimation {
                                    currentPageIndex = item.next.rawValue
                                }
                            }
                            .offset(x: 10)
                        }
                    }
                }
                .padding(.vertical, 30)
                .background(Color.graphite)
                .cornerRadius(50, corners: .topRight)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showRegistration) {
            RegistrationView()
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    OnboardingView(item: .first, currentPageIndex: .constant(0))
}
