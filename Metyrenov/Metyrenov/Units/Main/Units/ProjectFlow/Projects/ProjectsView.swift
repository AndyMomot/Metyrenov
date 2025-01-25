//
//  ProjectsView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var viewModel = ViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
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
                                Text("Twoje projekty")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                            
                            ProjectFilterView(selection: $viewModel.filter)
                            
                            if viewModel.projects.isEmpty {
                                HStack {
                                    Spacer()
                                    Text("Nie znaleziono projektów")
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
                                    ForEach(viewModel.projects) { project in
                                        Text(project.name)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.graphite)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadowModifier()
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
                
                VStack {
                    Spacer()
                    NextButton(title: "Dodaj nowy projekt") {
                        
                    }
                }
                .padding()
            }
            .onAppear {
                withAnimation {
                    viewModel.getProjects()
                }
            }
        }
    }
}

#Preview {
    ProjectsView()
}
