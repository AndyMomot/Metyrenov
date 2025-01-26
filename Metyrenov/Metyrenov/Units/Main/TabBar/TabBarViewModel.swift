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
        @Published var selection = TabBarSelectionView.home
        @Published var showTabBar = true
        @Published var showTeamTab = false
        
        @Published var items: [TabBar.Item] = [
            .init(imageName: Asset.homeTab.name,
                  tab: .home),
            .init(imageName: Asset.calendarTab.name,
                  tab: .calendar),
            .init(imageName: Asset.faqTab.name,
                  tab: .faq),
            .init(imageName: Asset.settingsTab.name,
                  tab: .settings)
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
                    self.items.insert(.init(imageName: Asset.profileTab.name,
                                            tab: .team), at: 2)
                } else {
                    self.items.removeAll(where: {$0.tab == .team})
                }
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView {
        case home
        case calendar
        case team
        case faq
        case settings
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        let imageName: String
        let tab: TabBarSelectionView
    }
}
