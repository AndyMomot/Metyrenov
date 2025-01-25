//
//  AddTeamMemberViewModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import Foundation
import UIKit.UIImage

extension AddTeamMemberView {
    final class ViewModel: ObservableObject {
        @Published var name = ""            { didSet { validate() } }
        @Published var phone = ""           { didSet { validate() } }
        @Published var email = ""           { didSet { validate() } }
        @Published var image = UIImage()    { didSet { validate() } }
        
        @Published var showImagePicker = false
        @Published var isValid = false
    }
}

extension AddTeamMemberView.ViewModel {
    func validate() {
        isValid = !name.isEmpty
        && !phone.isEmpty
        && !email.isEmpty
        && image != UIImage()
    }
    
    func addMember(teamID: String, completion: @escaping () -> Void) {
        Task { [weak self] in
            guard let self else { return }
            let member = TeamMember(
                fullName: self.name,
                phone: self.phone,
                email: self.email
            )
            
            let shared = DefaultsService.shared
            if let index = shared.teams.firstIndex(where: { $0.id == teamID }) {
                shared.teams[index].members.append(member)
                
                if let imageData = self.image.jpegData(compressionQuality: 1) {
                    FileManagerService().saveImage(data: imageData, for: member.id)
                }
                
                await MainActor.run {
                    completion()
                }
            }
        }
    }
}
