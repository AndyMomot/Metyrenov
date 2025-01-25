//
//  ProjectCell.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct ProjectCell: View {
    let project: Project
    @State private var image: Image?
    
    var body: some View {
        ZStack {
            ZStack {
                Color.graphite
                
                VStack(alignment: .leading, spacing: 4) {
                    ZStack(alignment: .bottom) {
                        if let image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 95, maxHeight: 95)
                                .padding(6)
                                .background(.graphite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(LinearGradient(
                                    colors: [.skywave, .azure],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .padding(6)
                                .background(.graphite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadowModifier()
                        }
                        
                        Text(project.date.toString(format: .ddMMyyyy))
                            .foregroundStyle(LinearGradient(
                                colors: [.skywave, .azure],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .font(.system(size: 8, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 9)
                            .padding(.horizontal, 30)
                            .background(.graphite)
                            .clipShape(Capsule())
                            .shadowModifier()
                    }
                    
                    Group {
                        Text(project.name)
                            .font(.system(size: 14, weight: .semibold))
                        Text(project.address)
                            .font(.system(size: 10, weight: .regular))
                        
                    }
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
            .background(.graphite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadowModifier()
            
            VStack {
                HStack {
                    Image(project.isFinished ? "projectFinished" : "projectInProgress")
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            getImage()
        }
    }
}

private extension ProjectCell {
    func getImage() {
        Task {
            guard let imageData = await FileManagerService().fetchImage(with: self.project.id),
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
        
        ScrollView {
            HStack {
                ProjectCell(project: .init(
                    isFinished: false,
                    name: "First",
                    date: .init(),
                    address: "123 avenue",
                    teamID: "",
                    description: "Description text",
                    budget: 100_000
                ))
                
                ProjectCell(project: .init(
                    isFinished: true,
                    name: "Second",
                    date: .init(),
                    address: "543 street",
                    teamID: "",
                    description: "Description text",
                    budget: 123_000
                ))
            }
            .padding()
        }
    }
}
