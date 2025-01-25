//
//  CreateProjectViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import Foundation
import UIKit.UIImage

extension CreateProjectView {
    final class ViewModel: ObservableObject {
        @Published var name = "" {
            didSet { validate() }
        }
        @Published var date = Date()
        @Published var address = ""  {
            didSet { validate() }
        }
        
        @Published var teams: [Team] = []
        @Published var selectedTeam: String?  {
            didSet { validate() }
        }
        
        @Published var description = ""  {
            didSet { validate() }
        }
        @Published var budget = ""  {
            didSet { validate() }
        }
        @Published var image = UIImage() {
            didSet { validate() }
        }
        
        @Published var showImagePicker = false
        @Published var isValid = false
        
        func getTeams() {
            Task { [weak self] in
                guard let self else { return }
                let allTeams = DefaultsService.shared.teams
                await MainActor.run {
                    self.teams = allTeams
                }
            }
        }
        
        func validate() {
            isValid = !name.isEmpty
            && !address.isEmpty
            && selectedTeam != nil
            && !description.isEmpty
            && Int(budget) ?? .zero > .zero
            && image != UIImage()
        }
        
        func saveProject(completion: @escaping () -> Void) {
            Task { [weak self] in
                guard let self else { return }
                guard let teamID = self.teams.first(where: { $0.name == self.selectedTeam })?.id
                else { return }
                
                let project = Project(
                    name: self.name,
                    date: self.date,
                    address: self.address,
                    teamID: teamID,
                    description: self.description,
                    budget: Int(self.budget) ?? .zero
                )
                
                DefaultsService.shared.projects.append(project)
                
                await MainActor.run {
                    completion()
                }
            }
        }
    }
}
