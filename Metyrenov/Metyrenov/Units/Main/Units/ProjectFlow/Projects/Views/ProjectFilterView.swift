//
//  ProjectFilterView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct ProjectFilterView: View {
    @Binding var selection: Filter
    
    var body: some View {
        HStack(spacing: 0) {
            ProjectFilterCheckBox(
                currentFilter: .all,
                selection: $selection
            )
            
            Spacer(minLength: 10)
            
            ProjectFilterCheckBox(
                currentFilter: .unFinished,
                selection: $selection
            )
            
            Spacer(minLength: 10)
            
            ProjectFilterCheckBox(
                currentFilter: .finished,
                selection: $selection
            )
        }
    }
}

extension ProjectFilterView {
    enum Filter {
        case all
        case unFinished
        case finished
        
        var title: String {
            switch self {
            case .all:
                return "Wszystkie projekty"
            case .unFinished:
                return "Aktualne projekty"
            case .finished:
                return "Zakończone projekty"
            }
        }
    }
}

#Preview {
    ZStack {
        Color.graphite
        ProjectFilterView(selection: .constant(.all))
            .padding()
    }
}
