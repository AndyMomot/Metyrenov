//
//  ProjectDetailsView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import SwiftUI

struct ProjectDetailsView: View {
    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    init(project: Project) {
        let viewModel = ViewModel(project: project)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                HStack {
                    BackButton(title: viewModel.project.name)
                    
                    Button {
                        viewModel.deleteProject {
                            dismiss.callAsFunction()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.redCustom)
                            .frame(width: 24, height: 24)
                    }
                }
                
                ScrollView {
                    VStack(spacing: 15) {
                        if viewModel.uiImage == UIImage() {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(LinearGradient(
                                    colors: [.skywave, .azure],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .padding()
                                .background(.graphite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadowModifier()
                                .padding(.horizontal, 68)
                        } else {
                            Image(uiImage: viewModel.uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 200, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding()
                                .background(.graphite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadowModifier()
                        }
                        VStack(spacing: 6) {
                            HStack(spacing: 10) {
                                Text("Termin ostateczny:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                ProjectInfoPresenter(text: viewModel.project.date.toString(format: .ddMMyyyy))
                                    .frame(width: screenWidth * 0.54)
                            }
                            
                            HStack(spacing: 10) {
                                Text("Adres:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                ProjectInfoPresenter(text: viewModel.project.address)
                                    .frame(width: screenWidth * 0.54)
                            }
                            
                            if let team = viewModel.team {
                                HStack(alignment: .top, spacing: 10) {
                                    Text("Zespół:")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.top, 5)
                                    Spacer()
                                    TeamCell(team: team)
                                        .frame(width: screenWidth * 0.54)
                                }
                            }
                            
                            HStack(alignment: .top, spacing: 10) {
                                Text("Opis projektu:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.top, 5)
                                Spacer()
                                ProjectInfoPresenter(text: viewModel.project.description, alignment: .leading)
                                    .frame(width: screenWidth * 0.54)
                            }
                            
                            HStack(spacing: 10) {
                                Text("Budżet:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                ProjectInfoPresenter(text: "\(viewModel.project.budget)")
                                    .frame(width: screenWidth * 0.54)
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
                
                if !viewModel.project.isFinished {
                    NextButton(title: "Zakończ projekt") {
                        withAnimation {
                            viewModel.finishProject()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.getImage()
            viewModel.getTeam()
        }
    }
}

#Preview {
    ProjectDetailsView(project: .init(
        name: "Remont kuchni",
        date: .init(),
        address: "Św. Nasyp, b. 98, trafny. 45",
        teamID: "",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        budget: 34_867)
    )
}
