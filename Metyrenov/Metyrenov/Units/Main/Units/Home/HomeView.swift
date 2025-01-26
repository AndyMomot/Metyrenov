//
//  HomeView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarViewModel: TabBar.ViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                NavigationBarView()
                    .padding(.trailing)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Aktualne projekty")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .semibold))
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.projects) { project in
                                        ProjectCell(project: project)
                                    }
                                }
                            }
                            .scrollIndicators(.never)
                        }
                        .padding(.vertical)
                        .padding(.leading)
                        .background(.graphite)
                        .cornerRadius(10, corners: [
                            .topLeft, .bottomLeft
                        ])
                        .shadowModifier()
                        
                        switch viewModel.userType {
                        case .company:
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Twoje zespoły")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 15) {
                                        ForEach(viewModel.teams) { team in
                                            TeamCell(team: team)
                                        }
                                    }
                                }
                                .scrollIndicators(.never)
                            }
                            .padding(.vertical)
                            .padding(.leading)
                            .background(.graphite)
                            .cornerRadius(10, corners: [
                                .topLeft, .bottomLeft
                            ])
                            .shadowModifier()
                        case .personal:
                            ProjectsChart(projects: viewModel.projects)
                        }
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
                        if viewModel.projects.isEmpty {
                            NextButton(title: "Dodaj nowy projekt") {
                                DispatchQueue.main.async {
                                    tabBarViewModel.selection = TabBar.TabBarSelectionView.calendar
                                }
                            }
                        }
                        
                        if viewModel.teams.isEmpty {
                            NextButton(title: "Wyświetl polecenia",
                                       titleColors: [.azure, .skywave],
                                       bgColors: [.graphite]) {
                                DispatchQueue.main.async {
                                    tabBarViewModel.selection = TabBar.TabBarSelectionView.team
                                }
                            }
                        }
                    }
                case .personal:
                    if viewModel.projects.isEmpty {
                        NextButton(title: "Dodaj nowy projekt") {
                            DispatchQueue.main.async {
                                tabBarViewModel.selection = TabBar.TabBarSelectionView.calendar
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getUser()
            viewModel.getProjects()
        }
    }
}

#Preview {
    HomeView()
}
