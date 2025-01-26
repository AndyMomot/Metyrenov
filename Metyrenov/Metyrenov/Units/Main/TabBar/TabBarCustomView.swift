//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    
    let items: [TabBar.Item]
    @Binding var selectedItem: TabBar.TabBarSelectionView
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.graphite)
                .shadowModifier()
                .ignoresSafeArea(edges: .horizontal)
            
            HStack(spacing: 0) {
                Spacer()
                ForEach(items) { item in
                    let isSelected = selectedItem == item.tab
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                selectedItem = item.tab
                            }
                        }
                    } label: {
                        VStack(spacing: 8) {
                            LinearGradient(
                                colors: [.azure, .skywave],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 10, height: 10)
                            .clipShape(Circle())
                            .hidden(!isSelected)
                            
                            Image(item.imageName)
                                .renderingMode(.template)
                                .foregroundStyle(
                                     LinearGradient(
                                        colors: isSelected ? [.azure, .skywave] : [.white],
                                    startPoint: .leading,
                                    endPoint: .trailing)
                                )
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct TabBarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarCustomView(items: [
            .init(imageName: Asset.homeTab.name,
                  tab: .home),
            .init(imageName: Asset.calendarTab.name,
                  tab: .calendar),
            .init(imageName: Asset.profileTab.name,
                  tab: .team),
            .init(imageName: Asset.faqTab.name,
                  tab: .faq),
            .init(imageName: Asset.settingsTab.name,
                  tab: .settings)
        ], selectedItem: .constant(.home))
            .previewLayout(.sizeThatFits)
    }
}
