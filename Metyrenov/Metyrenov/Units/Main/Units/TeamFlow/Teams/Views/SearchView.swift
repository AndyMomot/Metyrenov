//
//  SearchView.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import SwiftUI

struct SearchView: View {
    @Binding var query: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            TextField(text: $query) {
                Text("Szukaj")
                    .foregroundStyle(.white)
                    .font(.system(size: 10, weight: .light))
            }
            .foregroundStyle(.white)
            .font(.system(size: 10, weight: .regular))
            
            if !query.isEmpty {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.white)
                    .onTapGesture {
                        query = ""
                    }
            }
        }
        .padding()
        .background(Color.graphite)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        Color.graphite
        VStack(spacing: 20) {
            SearchView(query: .constant("123"))
            SearchView(query: .constant(""))
        }
        .padding()
    }
}
