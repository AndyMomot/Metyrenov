//
//  HomeViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var userType: User.UserType = .company
        @Published var projects: [Project] = []
        @Published var teams: [Team] = []
    }
}

extension HomeView.ViewModel {
    func getUser() {
        Task { [weak self] in
            guard let self, let userType = DefaultsService.shared.user?.type else { return }
            if userType == .company { self.getTeam() }
            
            await MainActor.run {
                self.userType = userType
            }
        }
    }
    
    func getProjects() {
        Task { [weak self] in
            guard let self else { return }
            let projects = DefaultsService.shared.projects
            await MainActor.run {
                self.projects = projects
            }
        }
    }
    
    func getTeam() {
        Task { [weak self] in
            guard let self else { return }
            let teams = DefaultsService.shared.teams
            await MainActor.run {
                self.teams = teams
            }
        }
    }
}
