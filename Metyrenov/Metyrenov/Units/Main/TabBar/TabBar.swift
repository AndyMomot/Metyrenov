//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: .zero) {
                TabView(selection: $viewModel.selection) {
                    Text("Home")
                        .tag(TabBarSelectionView.home.rawValue)
                        .environmentObject(viewModel)
                    
                    Text("Calendar")
                        .tag(TabBarSelectionView.calendar.rawValue)
                        .environmentObject(viewModel)
                    
                    if viewModel.showTeamTab {
                        Text("Team")
                            .tag(TabBarSelectionView.team.rawValue)
                            .environmentObject(viewModel)
                    }
                    
                    Text("FAQ")
                        .tag(TabBarSelectionView.faq.rawValue)
                    
                    Text("Settings")
                        .tag(TabBarSelectionView.settings.rawValue)
                        .environmentObject(viewModel)
                }
                
                if viewModel.showTabBar {
                    TabBarCustomView(items: viewModel.items,
                                     selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}
