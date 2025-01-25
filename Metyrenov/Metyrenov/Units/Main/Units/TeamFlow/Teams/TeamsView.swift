//
//  TeamsView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct TeamsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    NavigationBarView()
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            HStack {
                                Text("Twoje zespoły")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                            
                            SearchView(query: $viewModel.query)
                            
                            if viewModel.teams.isEmpty {
                                HStack {
                                    Spacer()
                                    Text("Nie znaleziono drużyn")
                                        .privacySensitive()
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                        
                                    Spacer()
                                }
                                .padding()
                                .background(Color.graphite)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .shadowModifier()
                                .padding(.vertical)
                            } else {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(viewModel.teams) { team in
                                        NavigationLink(value: team) {
                                            TeamCell(team: team)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.graphite)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadowModifier()
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    Spacer()
                    NextButton(title: "Utwórz nowy zespół") {
                        viewModel.showCreateTeam.toggle()
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.getTeams()
            }
            .navigationDestination(isPresented: $viewModel.showCreateTeam) {
                CreateTeamView()
            }
            .navigationDestination(for: Team.self) { team in
                Text(team.name)
            }
        }
    }
}

#Preview {
    TeamsView()
}
