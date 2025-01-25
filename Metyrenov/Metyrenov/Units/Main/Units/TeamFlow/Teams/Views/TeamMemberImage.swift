//
//  TeamMemberImage.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct TeamMemberImage: View {
    let imageId: String
    @State private var image: Image?
    
    var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.deepIndigo)
            }
        }
        .padding(5)
        .background(Color.white)
        .clipShape(Circle())
        .padding(5)
        .background(Color.graphite)
        .clipShape(Circle())
        .shadowModifier()
        .onAppear {
            withAnimation {
                getImage()
            }
        }
    }
}

private extension TeamMemberImage {
    func getImage() {
        Task {
            guard let imageData = await FileManagerService().fetchImage(with: self.imageId),
                  let uiImage = UIImage(data: imageData)
            else { return }
            
            await MainActor.run {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.graphite
        TeamMemberImage(imageId: UUID().uuidString)
            .frame(maxWidth: 44, maxHeight: 44)
    }
}
