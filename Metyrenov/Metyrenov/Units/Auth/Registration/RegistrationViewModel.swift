//
//  RegistrationViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import Foundation

extension RegistrationView {
    final class ViewModel: ObservableObject {
        @Published var nickname = ""
        @Published var type = User.UserType.personal
        
        func saveNickname(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let user = User(name: self.nickname, type: self.type)
                DefaultsService.shared.user = user
                completion()
            }
        }
    }
}
