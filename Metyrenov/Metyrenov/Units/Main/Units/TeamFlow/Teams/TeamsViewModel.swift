//
//  TeamsViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

extension TeamsView {
    final class ViewModel: ObservableObject {
        @Published var query = "" {
            didSet {
                performSearchWithDelay()
            }
        }
        @Published var teams: [Team] = []
        @Published var showCreateTeam = false
        
        private var searchTask: Task<Void, Never>?
    }
}

extension TeamsView.ViewModel {
    func getTeams() {
        Task { [weak self] in
            guard let self else { return }
            let queryText = self.query.trimmingCharacters(in: .whitespacesAndNewlines)
            let allTeams = DefaultsService.shared.teams
            let filteredTeams: [Team]
            
            if queryText.isEmpty {
                filteredTeams = allTeams
            } else {
                filteredTeams = allTeams.filter {
                    $0.name.lowercased().contains(queryText)
                }
            }
            
            await MainActor.run {
                self.teams = filteredTeams
            }
        }
    }
}

private extension TeamsView.ViewModel {
    private func performSearchWithDelay() {
        // Скасовуємо попередню задачу, якщо вона ще виконується
        searchTask?.cancel()
        
        // Запускаємо нову задачу
        searchTask = Task { [weak self] in
            guard let self else { return }
            try? await Task.sleep(nanoseconds: 500_000_000) // Затримка 0.5 секунди
            
            guard !Task.isCancelled else { return } // Перевірка на скасування
            
            self.getTeams()
        }
    }
}
