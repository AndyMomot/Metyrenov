//
//  CreateTeamView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct CreateTeamView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                BackButton(title: "Dodawanie nowego zespołu")
                
                ScrollView {
                    VStack(spacing: 15) {
                        CustomTextField(
                            title: "Nazwa zespołu",
                            placeholder: "Wprowadź nazwę...",
                            text: $viewModel.name)
                    }
                }
                
                NextButton(title: "Dodaj nowy zespół") {
                    viewModel.saveTeam {
                        dismiss.callAsFunction()
                    }
                }
                .disabled(viewModel.name.count < 3)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CreateTeamView()
}
