//
//  MenuPicker.swift

import SwiftUI

struct MenuPicker: View {
    let title: String
    let items: [String]
    var showAddButton = false
    var placeholder: String?
    @Binding var selection: String?
    
    var onAdd: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                Spacer()
                
                if showAddButton {
                    Button {
                        onAdd?()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.mist)
                            .fontWeight(.medium)
                            .padding(4)
                    }
                    
                }
            }
            
            Menu {
                ForEach(items, id: \.self) { item in
                    Button {
                        selection = item
                    } label: {
                        Text(item)
                    }
                }
            } label: {
                HStack {
                    Text(selection ?? placeholder ?? "-")
                        .foregroundStyle(.mist)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.mist)
                        .hidden(items.isEmpty)
                }
                .padding()
                .background(.graphite)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadowModifier()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.graphite
        
        VStack {
            MenuPicker(
                title: "Title",
                items: [
                    "Item 1", "Item 2", "Item 3"
                ],
                selection: .constant(""))
            
            MenuPicker(
                title: "Title",
                items: [],
                showAddButton: true,
                selection: .constant(nil)) {
                    
                }
        }
        .padding()
    }
}
