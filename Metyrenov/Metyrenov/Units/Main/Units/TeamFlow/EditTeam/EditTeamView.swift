//
//  EditTeamView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 25.01.2025.
//

import SwiftUI

struct EditTeamView: View {
    @StateObject var viewModel: ViewModel
    
    init(team: Team) {
        let viewModel = ViewModel(team: team)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @Environment(\.dismiss) private var dismiss
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                BackButton(title: viewModel.team.name)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.team.members) { member in
                            TeamMemberCell(member: member) {
                                viewModel.delete(member: member)
                            }
                        }
                    }
                }
                
                NextButton(title: "Nowy mistrz") {
                    viewModel.showAddMember.toggle()
                }
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $viewModel.showAddMember) {
            Text("addMember")
        }
    }
}

#Preview {
    NavigationStack {
        EditTeamView(team: .init(
            name: "Dream Team",
            members: [
                .init(fullName: "Alex", phone: "123", email: "@gmail"),
                .init(fullName: "Ted", phone: "456", email: "@gmail"),
                .init(fullName: "Robert", phone: "789", email: "@gmail"),
                .init(fullName: "Joe", phone: "012", email: "@gmail"),
                .init(fullName: "Lois", phone: "345", email: "@gmail"),
                .init(fullName: "Ruppert", phone: "678", email: "@gmail"),
                .init(fullName: "Bred", phone: "901", email: "@gmail"),
            ]
        ))
    }
}
