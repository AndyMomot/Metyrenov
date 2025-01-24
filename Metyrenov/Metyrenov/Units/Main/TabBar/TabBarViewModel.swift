//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation
import SwiftUI

extension TabBar {
    final class ViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.home.rawValue
        @Published var showTabBar = true
        @Published var showTeamTab = false
        
        @Published var items: [TabBar.Item] = [
            .init(imageName: Asset.homeTab.name),
            .init(imageName: Asset.calendarTab.name),
            .init(imageName: Asset.faqTab.name),
            .init(imageName: Asset.settingsTab.name)
        ]
        
        init() {
            getUser()
        }
        
        func showTabBar(_ show: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.showTabBar = show
            }
        }
    }
}

private extension TabBar.ViewModel {
    func getUser() {
        Task { [weak self] in
            guard let self else { return}
            let user = DefaultsService.shared.user
            let isCompanyType = user?.type == .company
            
            await MainActor.run {
                self.showTeamTab = isCompanyType
                if isCompanyType {
                    self.items.insert(.init(imageName: Asset.profileTab.name), at: 2)
                } else {
                    self.items.removeAll(where: {$0.imageName == Asset.profileTab.name})
                }
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case home = 0
        case calendar
        case team
        case faq
        case settings
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
    }
}
