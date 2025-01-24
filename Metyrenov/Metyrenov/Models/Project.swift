//
//  Project.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

struct Project: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var isFinished = false
    
    var name: String
    var date: Date
    var adress: String
    var team: Team
    var description: String
    var budjet: Int
}
