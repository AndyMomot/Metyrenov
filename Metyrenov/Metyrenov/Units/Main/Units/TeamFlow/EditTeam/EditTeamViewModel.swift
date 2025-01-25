//
//  EditTeamViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import Foundation

extension EditTeamView {
    final class ViewModel: ObservableObject {
        @Published var team: Team
        @Published var showAddMember = false
        
        init(team: Team) {
            self.team = team
        }
    }
}

extension EditTeamView.ViewModel {
    func delete(member: TeamMember) {
        Task { [weak self] in
            guard let self else { return }
            let shared = DefaultsService.shared
            if let index = shared.teams.firstIndex(where: { $0.id == self.team.id }) {
                shared.teams[index].members.removeAll(where: { $0.id == member.id })
                self.updateTeam()
            }
        }
    }
    
    func updateTeam() {
        Task { [weak self] in
            guard let self else { return }
            if let team = DefaultsService.shared.teams.first(where: { $0.id == self.team.id }) {
                await MainActor.run {
                    self.team = team
                }
            }
        }
    }
}
