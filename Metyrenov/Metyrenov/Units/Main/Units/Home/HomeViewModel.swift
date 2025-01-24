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
    }
}

extension HomeView.ViewModel {
    func getUser() {
        Task { [weak self] in
            guard let self, let userType = DefaultsService.shared.user?.type else { return }
            await MainActor.run {
                self.userType = userType
            }
        }
    }
}
