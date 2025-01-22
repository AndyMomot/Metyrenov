//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    private let items: [TabBar.Item] = [
        .init(imageName: Asset.homeTab.name),
        .init(imageName: Asset.calendarTab.name),
        .init(imageName: Asset.profileTab.name),
        .init(imageName: Asset.faqTab.name),
        .init(imageName: Asset.settingsTab.name)
    ]
    
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
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    let isSelected = selectedItem == index
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                selectedItem = index
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
        TabBarCustomView(selectedItem: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
