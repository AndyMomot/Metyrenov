//
//  CreateTeamViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import Foundation

extension CreateTeamView {
    final class ViewModel: ObservableObject {
        @Published var name: String = ""
        
        func saveTeam(completion: @escaping () -> Void) {
            Task { [weak self] in
                guard let self else { return }
                let team = Team(name: self.name)
                DefaultsService.shared.teams.append(team)
                await MainActor.run {
                    completion()
                }
            }
        }
    }
}
