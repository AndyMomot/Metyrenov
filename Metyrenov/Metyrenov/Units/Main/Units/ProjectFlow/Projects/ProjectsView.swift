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
                            
                            Spacer()
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(viewModel.projects) { project in
                                        NavigationLink(value: project) {
                                            ProjectCell(project: project)
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.never)
                        }
                    }
                    .padding()
                    .background(Color.graphite)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadowModifier()
                    
                }
                .padding(.horizontal)
                
                VStack {
                    Spacer()
                    NextButton(title: "Dodaj nowy projekt") {
                        viewModel.showCreateProject.toggle()
                    }
                }
                .padding()
            }
            .onAppear {
                withAnimation {
                    viewModel.getProjects()
                }
            }
            .navigationDestination(isPresented: $viewModel.showCreateProject) {
                CreateProjectView()
            }
            .navigationDestination(for: Project.self) { project in
                ProjectDetailsView(project: project)
            }
        }
    }
}

#Preview {
    ProjectsView()
}
