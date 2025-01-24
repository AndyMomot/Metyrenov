//
//  TeamMemberModel.swift
//  Metyrenov
//
//  Created by Andrii Momot on 24.01.2025.
//

import Foundation

struct TeamMember: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var fullName: String
    var phone: String
    var email: String
}
