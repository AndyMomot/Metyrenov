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
                    HomeView()
                        .tag(TabBarSelectionView.home)
                        .environmentObject(viewModel)
                    
                    ProjectsView()
                        .tag(TabBarSelectionView.calendar)
                        .environmentObject(viewModel)
                    
                    if viewModel.showTeamTab {
                        TeamsView()
                            .tag(TabBarSelectionView.team)
                            .environmentObject(viewModel)
                    }
                    
                    Text("FAQ")
                        .tag(TabBarSelectionView.faq)
                    
                    Text("Settings")
                        .tag(TabBarSelectionView.settings)
                        .environmentObject(viewModel)
                }
                
                if viewModel.showTabBar {
                    TabBarCustomView(
                        items: viewModel.items,
                        selectedItem: $viewModel.selection
                    )
                    .background(Color.graphite)
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
