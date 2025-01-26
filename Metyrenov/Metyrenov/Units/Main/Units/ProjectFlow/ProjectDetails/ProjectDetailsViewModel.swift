//
//  ProjectDetailsViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 26.01.2025.
//

import Foundation
import UIKit.UIImage

extension ProjectDetailsView {
    final class ViewModel: ObservableObject {
        @Published var project: Project
        @Published var uiImage = UIImage()
        @Published var team: Team?
        
        init(project: Project) {
            self.project = project
        }
    }
}

extension ProjectDetailsView.ViewModel {
    func getImage() {
        Task { [weak self] in
            guard let self else { return }
            guard let imageData = await FileManagerService().fetchImage(with: self.project.id),
                  let uiImage = UIImage(data: imageData)
            else { return }
            
            await MainActor.run {
                self.uiImage = uiImage
            }
        }
    }
    
    func getTeam() {
        Task { [weak self] in
            guard let self else { return }
            let team = DefaultsService.shared.teams.first(where: { $0.id == self.project.teamID })
            await MainActor.run {
                self.team = team
            }
        }
    }
    
    func deleteProject(completion: @escaping () -> Void) {
        Task { [weak self] in
            guard let self else { return }
            DefaultsService.shared.projects.removeAll(where: {$0.id == self.project.id})
            await MainActor.run {
                completion()
            }
        }
    }
    
    func finishProject() {
        Task { [weak self] in
            guard let self else { return }
            let shared = DefaultsService.shared
            if let index = shared.projects.firstIndex(where: { $0.id == self.project.id }) {
                shared.projects[index].isFinished = true
                let updatedProject = shared.projects[index]
                
                await MainActor.run {
                    self.project = updatedProject
                }
            }
        }
    }
}
