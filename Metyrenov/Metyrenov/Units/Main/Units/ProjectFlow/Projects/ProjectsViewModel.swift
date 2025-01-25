//
//  ProjectsViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

extension ProjectsView {
    final class ViewModel: ObservableObject {
        @Published var filter = ProjectFilterView.Filter.all {
            didSet {
                getProjects()
            }
        }
        @Published var projects: [Project] = []
        
        @Published var showCreateProject = false
    }
}

extension ProjectsView.ViewModel {
    func getProjects() {
        Task { [weak self] in
            guard let self else { return }

            // Make a copy of the projects array outside the task
            let allProjects = DefaultsService.shared.projects

            // Filter projects based on the filter type
            let filteredProjects: [Project] // Replace `Project` with the actual type of the items in the array
            switch self.filter {
            case .all:
                filteredProjects = allProjects
            case .unFinished:
                filteredProjects = allProjects.filter { !$0.isFinished }
            case .finished:
                filteredProjects = allProjects.filter { $0.isFinished }
            }

            // Update the `projects` property on the main thread
            await MainActor.run {
                self.projects = filteredProjects
            }
        }
    }
}
